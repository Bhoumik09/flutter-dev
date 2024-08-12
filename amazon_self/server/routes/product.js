let express = require("express");
const admin = require("../middleware/admin");
const Product = require("../model/Product");
const auth = require("../middleware/auth");
let router = express.Router();

router.get('/api/products',auth,async(req,res)=>{
    try{
        console.log(req.query.category);
        const products=await Product.find({category:req.query.category});
        res.status(200).json(products)
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
})
module.exports=router;
router.get('/api/products/search/:name',auth,async(req,res)=>{
    try{
        let {name}=req.params;
        const products=await Product.find({
            name:{$regex:name,$options:'i'}
        });
        res.status(200).json(products)
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
})