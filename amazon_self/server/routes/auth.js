let express = require("express");
let router = express.Router();
const mongoose = require("mongoose");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();
mongoose
  .connect(
    `mongodb+srv://bhoumikchopra2022:${process.env.mongodbPsd}@cluster0.zxromnq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`
  )
  .then(() => {
    console.log("connection succesfull");
  })
  .catch((e) => {
    console.log(e.message);
  });
const User = require("../model/user");
const auth = require("../middleware/auth");

router.post("/api/signup", async (req, res) => {
  let { name, password, email } = req.body;
  console.log(req.body);
  let existingUser = await User.findOne({ email });
  if (existingUser) {
    res.status(400).json({ msg: "User already exists" });
    return;
  }
  password = await bcryptjs.hash(password, 8);

  try {
    await User.create({ name, email, password });
    res.status(200).json({ msg: "User created successfully" });
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});
router.post("/api/signin", async (req, res) => {
  const { email, password } = req.body;
  try {
    let user = await User.findOne({ email });
    
    if (!user) return res.status(400).json({ msg: "No user found" });

    if (!(await bcryptjs.compare(password, user.password))) return res.status(400).json({ msg: "Incorrect password" });
    
   
    const token = jwt.sign({ id: user._id }, "passwordKey");

    return res.json({ token, ...user._doc });
    // here we have just destrcutured the data and user_doc basically help us to senfd all the data as one ojbect rather than this {
    //     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    //     "user": {
    //       "_id": "60d5ecb74e90c62a3c9270a1",
    //       "email": "johndoe@example.com",
    //       "name": "John Doe",
    //       "age": 30,
    //       "role": "user"
    //     }
    //   }

    //avoid tampering of data
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
router.post("/tokenIsValid", async (req, res) => {
  const { email, password } = req.body;
  try {
    const token=req.header('x-auth-token');
    if(!token)return res.json(false);
    // here it checks that if the token is empty, then return false 
    const verify=jwt.verify(token,'passwordKey');
    if(!verify)return res.json(false);
    // here it verifies ki it is a valid tokwn or not according to secreet key 
    const user=await User.findById(verify.id);
    if(!user)return res.json(false);
    // here it sees that is there a user with that token or not 
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
router.get('/',auth,async(req,res)=>{
      const user= await User.findById(req.user);
      res.json({...user._doc,token:req.token});
})
module.exports = router;
