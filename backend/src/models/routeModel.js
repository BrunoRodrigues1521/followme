'use strict';
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const routeSchema= new Schema({
    name: {
        type: String,
        required: 'A name is needed'
    },
    description: {
        type: String,
        required: 'A description is needed'
    },
    visibility: {
        type: Boolean
    },
    difficulty: {
        type: Number,
    },
    rating: {
        type: Number
    },
    tags:[{
        type: String
    }],
    distance:{
        type: Number,
        required: 'A distance is needed'
    },
    reviews:[{
        content: String,
        username: String,
        picture: String,
        email: String,
        images:[{type:String}]
    }],
    images:[{
        type: String
    }],
    city:{
        type: String
    },
    email:{
        type: String
    },
    waypoints:[{
        lat: String,
        lon: String
    }],
},{collection: 'RouteCollection'} )
module.exports = mongoose.model('Route', routeSchema);