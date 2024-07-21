let express= require('express');
let router = express.Router();
const mongoose= require('mongoose');
const bcryptjs=require('bcryptjs');
const jwt= require('jsonwebtoken');
require('dotenv').config();
mongoose.connect(`mongodb+srv://bhoumikchopra2022:${process.env.mongodbPsd}@cluster0.zxromnq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`).then(()=>{
    console.log('connection succesfull');
    
}).catch((e)=>{
    console.log(e.message);
})
const User = require('../model/user');

router.post('/api/signup',async(req,res)=>{
        let {name,password, email}=req.body;
        console.log(req.body);
        let existingUser=await User.findOne({email});
        if(existingUser){
            res.status(400).json({'msg':'User already exists'});
            return;
        }
        password=await bcryptjs.hash(password,8);
        
        try{
            await User.create({name,email,password});
            res.status(200).json({'msg':"User created successfully"});
        }
        catch(e){ 
            res.status(400).json({'error':e.message});
        }

})
router.post('/api/signin',async(req,res)=>{
    const {email,password}=req.body;
    try{
        let user=await User.findOne({email});
        console.log(user);
        if(!user)res.status(400).json({'msg':"No user found"});
        if(!await bcryptjs.compare(password,user.password)){
            res.status(400).json({'msg':"Incorrect password"});
        }
        const token=jwt.sign({id:user._id},'passwordKey');
        res.json({token,...user._doc});
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




    }
    catch(e){
        res.status(500).json({error:e.message})
    }
    

})
module.exports=router;