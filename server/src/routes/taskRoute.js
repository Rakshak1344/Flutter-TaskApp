const express = require('express')
const Task = require('../models/task')

const router = express.Router()

router.post('/posttask', async (req, res) => {
    const task = new Task(req.body)
    try {
        await task.save()
        res.status(201).send({ "status": true })
    } catch (e) {
        res.status(400).send({ "status": false })
    }
})

router.get('/alltask', async (req, res) => {
    try {
        const allTask = await Task.find({})
        res.status(200).send(allTask)
    } catch (e) {
        res.status(400).send({ "status": false })
    }
})

router.delete('/deletetaskbyid/:id', async (req, res) => {
    try {
        await Task.findOneAndDelete({ _id: req.params.id })
        res.status(200).send({ "status": true })
    } catch (e) {
        res.status(404).send({ "status": false })
    }
})

router.patch('/updatetask/:id', async (req, res) => {
    const updates = Object.keys(req.body)
    try {
        const task = await Task.findByIdAndUpdate(req.params.id, req.body)
        if (!task) {
            return res.status(404).send({ "status": false })
        }
        updates.forEach((update) => task[update] = req.body[update])
        task.save()
        res.status(201).send({ "status": true })
    } catch (e) {
        res.status(400).send({ "status": false })
    }
})

router.delete('/deleteAllTask', async (req, res) => {
    try {
        await Task.deleteMany(req.body)
        return res.status(200).send({ "status": true })
    } catch (e) {
        res.status(400).send({ "status": false })
    }
})


module.exports = router