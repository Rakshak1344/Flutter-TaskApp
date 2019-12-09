const mongoose = require('mongoose')
const chalk = require('chalk')

mongoose.connect('mongodb://localhost:27017/flutter-taskApp', {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useUnifiedTopology: true
}, (error) => {
    error 
    ? console.log(chalk.white.bgRed('Unable to connect to database'))
    : console.log(chalk.white.bgGreen('connection successful'))
})