const express = require("express");
const app = express();
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const userRoute = require("./routes/user");
const authRoute = require("./routes/auth");
const cardataRoute = require("./routes/cardata");
const bookinghistoryRoute = require("./routes/bookinghistory");
const cors = require("cors");
dotenv.config();

mongoose
 .connect(process.env.MONGO_URL)
 .then(()=> console.log("DB connected"))
 .catch((err)=>{
     console.log(err);
 });
app.use(cors());
app.use(express.json());
app.use("/api/auth", authRoute);
app.use("/api/cardata",cardataRoute);
app.use("/api/users", userRoute);
app.use("/api/bookinghistory", bookinghistoryRoute);
let port = process.env.PORT;
if(port == null|| port ==""){
    port =5000
}

app.listen(process.env.PORT || 5000, ()=>{
    console.log("backend is running");
});