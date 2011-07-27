#
# Handler to save new scores
#

mongoose = require 'mongoose'
require '../models/scores'
Score  = mongoose.model('Score')
Course = mongoose.model('Course')

# Show an empty form to create a new score
exports.new = (req,res) ->
    get_next_hole req.course, (next_hole) ->
        res.render 'scores/new', locals: course:req.course, hole:next_hole

# Save a new score
exports.create = (req,res) ->
    score = new Score()
    score.course       = req.course._id
    score.hole         = req.body.score.hole
    score.shots        = req.body.score.shots
    score.notes        = req.body.score.notes
    score.save ->
        res.redirect('/courses/'+score.course+'/scores/new')

# Returns last hole scored + 1
get_next_hole = (course,callback) ->

    Score.find {course:course._id}, (err,scores) ->

        if scores.length
            callback scores[scores.length-1].hole+1
        else
            callback 1
