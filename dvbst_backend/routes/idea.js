const express = require('express')
const router = express.Router()
const Idea = require('../models/idea')

router.get('/', async function(req, res){
    try{
        const ideas = await Idea.find()
        res.json(ideas);
    } catch(err){
        res.status(500).json({message: err.message});
    }
});

router.post('/', async function(req, res){
    const idea = new Idea({
        username: req.body.username,
        title: req.body.title,
        description: req.body.description,
        voteCount: req.body.voteCount
    })
    try{
        const newIdea = await idea.save()
        res.status(201).json(newIdea)
    } catch(err){
        res.status(400).json({message: err.message});
    }
});

router.patch('/:id', getIdea, async function(req, res){
    if (req.body.username != null){
        res.idea.username = req.body.username
    }
    if (req.body.title != null){
        res.idea.title = req.body.title
    }
    if (req.body.description != null){
        res.idea.description = req.body.description
    }
    if (req.body.voteCount != null){
        res.idea.voteCount = req.body.voteCount
    }

    try{
        const updatedIdea = await res.idea.save()
        res.status(204).json(updatedIdea)
    } catch(err){
        res.status(400).json({message: "Can't update Vote count"})
    }
});

async function getIdea(req, res, next){
    let idea
    try{
        idea = await Idea.findById(req.params.id)
        if (idea == null){
            return res.status(404).json({message: "Can't find idea"})
        } 
    } catch (err){
        return res.status(500).json({message: err.message})
    }
    res.idea = idea
    next()
}

module.exports = router