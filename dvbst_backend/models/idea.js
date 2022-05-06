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
    likes: {
        type: Array,
        required: true, 
        default: []
    },
    likeCount: {
        type: Number,
        required: true,
        default: 0
    },
    likedUser: {
        type: Boolean,
        required: true,
        default: false
    }
})

module.exports = mongoose.model('Idea', ideaSchema)
