require('dotenv').config({path:"env/.env"})
const mongoose = require('mongoose');

const mongodb = {
    pathLocalhost: 'mongodb://localhost/followme',
    pathAtlas: `mongodb+srv://${process.env.DB_USER}:${process.env.DB_PASSWORD}@followme.4obgk.mongodb.net/followme?retryWrites=true&w=majority`,

};
const dbc = mongodb.pathAtlas
    
    mongoose.connect(
        dbc,
        { useNewUrlParser: true, useUnifiedTopology: true});
    
    mongoose.connection.on('connected', () => { 
             console.log(`Connected to mongoDB`);
        });
    mongoose.connection.on('error', err => {
            console.log('Error connecting: ', err);
        });
    mongoose.connection.on('disconnected', () => { 
            console.log('Mongoose: connection abborted '); 
    });

