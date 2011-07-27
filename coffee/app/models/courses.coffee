#
# Course schema
#

mongoose = require 'mongoose'
Schema   = mongoose.Schema

schema = new Schema
  name:        String
  description: String
  price:       Number

mongoose.model 'Course', schema
