const express = require('express')
const router = express.Router()
const Idea = require('../models/idea')

router.get('/', async function(req, res){
    try{
        const ideas = await Idea.find().lean();
        const response = ideas.map(idea => {
            idea.likes = []
            return idea
        })
        res.json(response);
    } catch(err){
        res.status(500).json({message: err.message});
    }
});

router.post('/', async function(req, res){
    const idea = new Idea({
        username: req.body.username,
        title: req.body.title,
        description: req.body.description
    })
    try{
        const newIdea = await idea.save()
        res.status(201).json(newIdea)
    } catch(err){
        res.status(400).json({message: err.message});
    }
});

router.patch('/:id', async function(req, res){
    const idea = await Idea.findById(req.params.id)

    if (idea.likes.includes(req.body.user_id)){
        idea.likes = (idea.likes).filter(e => e !== req.body.user_id)
        idea.likeCount--
        idea.likedUser = false
    }else{
        idea.likes.push(req.body.user_id)
        idea.likeCount++
        idea.likedUser = true
    }

    try{
        const updatedIdea = await idea.save()
        res.json(updatedIdea)
    } catch(err){
        res.status(400).json({message: "Can't update Vote count"})
    }
});

module.exports = router