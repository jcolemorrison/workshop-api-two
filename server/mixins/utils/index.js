'use strict'

exports.updateTimestamps = function updateTimestamps (context, next) {
  // if update to a singular instance
  if (context.instance) {
    context.instance.updatedAt = new Date()
  } else {
  // if update to batch of instances
    context.data.updatedAt = new Date()
  }

  next()
}
