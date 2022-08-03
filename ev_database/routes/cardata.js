const cardata = require("../models/Cardata");
const { verifyandAdmin, verifyandauthen, verifytoken } = require("./verifyToken");

const router = require("express").Router();
//add car data admin only
router.post("/add",verifyandAdmin,async (req,res)=>{
    const newCardata = new cardata(req.body);
    try{
        const savedCardata = await newCardata.save();
        res.status(200).json(savedCardata);
    }catch(err){
        res.status(500).json(err);
    }

});
//edit data user admin only
router.put("/update/:id",verifyandAdmin,async (req,res)=>{
    try{
        const updatedCardata = await cardata.findByIdAndUpdate(
            req.params.id,
            {
                $set:req.body,
            },
            {new:true}
        );
        res.status(200).json(updatedCardata);
    }catch(err){
        res.status(500).json(err);
    }
});
//delete data user admin only
router.delete("/delete/:id",verifyandAdmin,async (req,res)=>{
    try{
        const deletedCardata = await cardata.findByIdAndDelete(req.params.id);
        const title = deletedCardata._doc.title;
        res.status(200).json(title+" has been deleted");
    }catch(err){
        res.status(500).json(err);
    }
});
//find cardata
router.get("/find/:id",verifytoken,async (req,res)=>{
    try{
        const foundCardata = await cardata.findById(req.params.id);
        res.status(200).json(foundCardata);
    }catch(err){
        res.status(500).json(err);
    }
});
//find all cardata
router.get("/findall",verifytoken,async (req,res)=>{

  try {
    let cardatas;
   
      cardatas =await cardata.find();
        res.status(200).json(cardatas);
    }catch(err){
        res.status(500).json(err);
    }
});

module.exports = router