
const app = express();
const dotenv = require("dotenv");
const express = require('mongoose');
const userroute = require("./routes/user");
const cors = require("cors")

dotenv.config();

mongoose
 .connect(process.env.MONGO_URL)
 .then(()=> console.log("DB connected"))
 .catch((err)=>{
     console.log(err);
 });
app.use(cors());
app.use(express.json());

app.listen(process.env.PORT || 5000, ()=>{
    console.log("backend is runninghhh");
});