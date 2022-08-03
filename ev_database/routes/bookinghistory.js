const Bookinghistory = require("../models/Bookinghistory");
const { verifyandAdmin, verifyandauthen, verifytoken } = require("./verifyToken");

const router = require("express").Router();
router.post("/add",verifyandAdmin,async (req,res)=>{
    const newBookinghistory = new Bookinghistory(req.body);
    try{
        const savedBookinghistory = await newBookinghistory.save();
        res.status(200).json(savedBookinghistory);
    }catch(err){
        res.status(500).json(err);
    }

});
router.put("/update/:id",verifyandAdmin,async (req,res)=>{
    try{
        const updatedBookinghistory = await Bookinghistory.findByIdAndUpdate(
            req.params.id,
            {
                $set:req.body,
            },
            {new:true}
        );
        res.status(200).json(updatedBookinghistory);
    }catch(err){
        res.status(500).json(err);
    }
});

module.exports = router