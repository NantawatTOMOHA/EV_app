const mongoose = require("mongoose");

const BookinghistorySchema = new mongoose.Schema(
    {
    username: {type:String,required: true},
    Time: {type:String,required: true},
    Timetoarrived: {type:String,required: true},
    TypeCar: {type:String,required: true},
    TypeCharger: {type:String,required: true},
    station: {type:String,required: true},
    cost: {type:Number,required: true},
    status: {type:String,required: true},
    

},
  
    );
    module.exports = mongoose.model("Bookinghistory",BookinghistorySchema);