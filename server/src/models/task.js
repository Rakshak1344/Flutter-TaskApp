const mongoose = require('mongoose')

const taskSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
    }, task: {
        required: false,
        type: String
    }
})

const Task = mongoose.model('Task',taskSchema)
module.exports = Task