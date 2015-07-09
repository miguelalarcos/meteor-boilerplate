Meteor.publish 'postById', (postId) ->
  posts.find postId

Meteor.publish 'postsWithSkip', (skip, limit) ->
  Counts.publish(this, 'total_posts', posts.find())
  if skip < 0 then skip = 0
  options = {}
  options.skip = skip
  options.limit = limit
  if options.limit > 10 then options.limit = 10
  options.sort = {createdAt: 1}
  posts.find({}, options)