const jwt= require('jsonwebtoken');
const User = require('../model/user');
const admin= async(req,res,next)=>{
    try{
        const token= req.header('x-auth-token');
        if(!token)res.status(401).json({'msg':'No auth token , access denied'});
        console.log(token);
        const verify=jwt.verify(token,'passwordKey');
        if(!verify)return res.status(401).json({msg:'token verification failed , authorization denied '});
        const user=await User.findById(verify.id);
        console.log(user);
        if(user.type==='user' || user.type ==='seller'){
            return res.status(401).json({"msg":"You are not an admin"});
        }
        req.user=verify.id;
        req.token=token;
        next();
    }catch(e){
        res.status(500).json({'error':e.message});
    }
}
module.exports=admin;