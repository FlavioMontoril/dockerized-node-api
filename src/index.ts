import dotenv from "dotenv"
import cors from "cors"
import express from "express"

dotenv.config()

const PORT = process.env.PORT || 4002
const app = express()

app.use(express.json())
app.use(cors())
app.use(express.urlencoded({extended: true}))

app.listen(PORT, ()=> {
    console.log(`Server is running on port: ${PORT}`)
});