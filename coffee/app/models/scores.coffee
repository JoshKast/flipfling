#
# Score schema
#

mongoose = require 'mongoose'
Schema   = mongoose.Schema

schema = new Schema
  course: String
  hole:   Number
  shots:  Number
  notes:  String

schema.static
    purge: (course_id,callback) ->

        Score = this
        this.find {course:course_id}, (err,docs) ->

            remove_scores = (scores,callback) ->
                if scores.length == 0
                    callback()
                else
                    Score.findById scores[0]._id, (err,score) ->
                        score.remove()
                        remove_scores scores.slice(1),callback

            remove_scores docs,callback

mongoose.model 'Score', schema
