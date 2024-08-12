let express = require("express");
const admin = require("../middleware/admin");
const Product = require("../model/Product");
let router = express.Router();
router.post('/admin/add-product',admin,async(req,res)=>{
    try{
        const {name,description,images,quantity,price,category}=req.body;
        console.log(res.body);
        let response=await Product.create({name,description,images,quantity,price,category});
        res.json(response);
    }
    catch(e){
        
        res.status(500).json({error:e.message})
    }
})
router.get('/admin/get-products',admin,async(req,res)=>{
    try{
        
        let response=await Product.find({});
        console.log(response.length);
        res.status(200).json(response);
    }
    catch(e){
        console.log(e.message);
        res.status(500).json({error:e.message})
    }
})
router.post('/admin/delete-product',admin,async(req,res)=>{
    try{
        let {id}=req.body
        let response=await Product.findByIdAndDelete(id
            
        );
        console.log(response.length);
        res.status(200).json(response);
    }
    catch(e){
        console.log(e.message);
        res.status(500).json({error:e.message})
    }
})
module.exports=router;