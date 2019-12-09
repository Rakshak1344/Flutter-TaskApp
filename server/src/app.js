const express = require('express')
const chalk = require('chalk')
const taskRoute = require('./routes/taskRoute')
require('./mongoose-connect')

const app = express()
const port = 3000

app.use(express.json())
app.use(taskRoute)

app.listen(port ,()=>{
    console.log(chalk.green.bgWhite.inverse(`server is up on port ${port}`))
})