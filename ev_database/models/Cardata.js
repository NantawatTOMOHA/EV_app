const mongoose = require("mongoose");

const CardataSchema = new mongoose.Schema(
    {
    title: {type:String,required: true},
    accelerate: {type:Number,required: true},
    battery: {type:Number,required: true},
    velocity: {type:Number,required: true},
    a: {type:Array,required: true},
    b: {type:Array,required: true},
    c: {type:Array,required: true},
    d: {type:Number,required: true},
    e: {type:Number,required: true},
    f: {type:String,required: true},
    g: {type:String,required: true},

},
    { timestamps:true }
);
module.exports = mongoose.model("Cardata",CardataSchema);