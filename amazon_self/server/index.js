const express = require('express');
const app = express();
const mongoose = require('mongoose');
const authRoutes=require('./routes/auth');
const session=require('express-session');
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    
}))
const port=5050;
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(authRoutes);
app.listen(port, ()=>{
    console.log("Connected to port 5050");
})
