i18n.permit(['insert', 'update', 'remove']).never().apply()
posts.permit(['remove']).never().apply()
comments.permit(['update', 'remove']).never().apply()

Security.defineMethod "ifIsOwner",
  fetch: []
  transform: null
  deny: (type, arg, userId, doc) ->
    userId != doc.owner

Security.defineMethod "ifSbValidate",
  fetch: [],
  transform: null,
  deny: (type, arg, userId, doc, fields, modifier) ->
    if type == 'update'
      doc = modifier['$set']
    if sb.validate(doc, arg.schema)
      false
    else
      true

posts.permit('update').ifLoggedIn().ifSbValidate(Post).onlyProps(['title', 'text', 'images', 'updatedAt']).ifIsOwner().apply()
posts.permit('insert').ifLoggedIn().ifSbValidate(Post).apply()

Security.defineMethod "ifIsPostAlive",
  fetch: []
  transform: null
  deny: (type, arg, userId, doc) ->
    createdAt = posts.findOne(doc.postId).createdAt
    moment().diff(moment(createdAt), 'minutes') > arg.asMinutes()

comments.permit('insert').ifLoggedIn().ifIsPostAlive(moment.duration(2, 'days')).ifSbValidate(Comment).apply()


