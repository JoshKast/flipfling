#
# CRUD express-resource handlers for course actions
#

mongoose = require 'mongoose'
require '../models/courses'
Course = mongoose.model('Course')

exports.play = (req,res) ->
    console.log('play')
    res.redirect('/courses/'+course._id.toHexString()+'/scores/new')

# Display a list of courses with links to view details
exports.index = (req,res) ->
    Course.find {}, (err,courses) ->
        res.render 'courses/index', locals: courses:courses

# Show an empty form to create a new course
exports.new = (req,res) ->
    res.render 'courses/new', locals: course:{}

# Show course details
exports.show = (req,res) ->
    res.render 'courses/show', locals: course:req.course

# Show a form to update course name, description and price
exports.edit = (req,res) ->
    res.render 'courses/edit', locals:course:req.course

# Save a new course and redirect to the new course's detail page
exports.create = (req,res) ->
    course = new Course()
    course.name        = req.body.course.name
    course.description = req.body.course.description
    course.price       = req.body.course.price
    course.save ->
        res.redirect('/courses/'+course._id.toHexString())

# Update a course in the DB and redirect to course detail page
exports.update = (req,res) ->
    course = req.course
    course.name        = req.body.course.name
    course.description = req.body.course.description
    course.price       = req.body.course.price
    course.save ->
        res.redirect('/courses/'+course._id.toHexString())

# Pre-handler, assigns req.course when there's an id in the uri
exports.load = (id,callback) ->
    Course.findById id, (err,course) ->
        callback(null,course);
