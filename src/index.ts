import dotenv from "dotenv"
import cors from "cors"
import express from "express"

dotenv.config()

const PORT = process.env.PORT
const app = express()

app.use(express())
app.use(cors())
app.use(express.urlencoded({extended: true}))

app.listen(PORT, ()=> {
    console.log(`Server is running on port: ${PORT}`)
});