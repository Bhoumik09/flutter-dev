const mongoose = require('mongoose');

let productSchema = new mongoose.Schema({
    name: {
        type: String,
        trim: true,
        required: true
    },
    description: {
        type: String,
        trim: true,
        required: true
    },
    images: [
        {
            type:String,
            required:true,

        }
    ]
        
    ,
    quantity: {
        type: Number,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    category: {
        type: String,
        trim: true,
        required: true
    }
    
});

let Product = mongoose.model('Product', productSchema);

module.exports = Product;
