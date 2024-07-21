let express= require('express');
const passportLocalMongoose = require('passport-local-mongoose');
let router = express.Router();
const mongoose= require('mongoose');
const User = require('../model/Users');
require('dotenv').config();
mongoose.connect(`mongodb+srv://bhoumikchopra2022:${process.env.mongodbPsd}@cluster0.zxromnq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`).then(()=>{
    console.log('connection succesfull');
    
}).catch((e)=>{
    console.log(e.message);
})
const bcryptjs=require('bcryptjs');


router.post('/api/signup', async (req, res) => {
    console.log('welcome');
    let { name, email, password } = req.body;
    password=await bcryptjs.hash(password,8);
    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: 'User with same email already exists' });
        }
       console.log(req.body);
        await User.create({name,email,password});
        res.status(201).json({ msg: 'User registered successfully' });
    } catch (e) {
        console.error(e);
        res.status(500).json({ msg: 'An error occurred during registration', error: e.message });
    }
});
module.exports=router;