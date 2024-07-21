const mongoose=require('mongoose');
let  userSchema= new mongoose.Schema({
    name:{
        type:String,
        trim:true,
        required:true
    },
    email:{
        type:String,
        trim:true,
        required:true
    },
    password:{
        type:String,
        trim:true,
        required:true
    },
    address:{
        type:String,
        trim:true,
        default:''
    },
    type:{
        type:String,
        trim:true,
        default:'user'
    }
})
let User=mongoose.model('People',userSchema);
module.exports=User;