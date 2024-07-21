let express = require('express');
let app = express();
let authRouter= require('./route/auth')
const session = require('express-session')
const LocalStrategy=require('passport-local');
const passport=require('passport');
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    
}))
const port=5050;

app.use(express.json());

app.use(express.urlencoded({ extended: true })) 

app.use(authRouter);
app.listen(5000,()=>{
    console.log("listening on port 5000");
})
