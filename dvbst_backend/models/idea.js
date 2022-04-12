const mongoose = require('mongoose')

const ideaSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true        
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    voteCount: {
        type: Number,
        required: true, 
        default: 0
    }
})

module.exports = mongoose.model('Idea', ideaSchema)
