if Meteor.isServer
  CollectionBehaviours.defineBehaviour 'ownerable', (getTransform, args) ->
    self = this
    self.before.insert (userId, doc) ->
      doc.owner = userId
      doc.username = Meteor.users.findOne(userId).username

  CollectionBehaviours.defineBehaviour 'sanitizable', (getTransform, args) ->
    self = this
    allowed = ['b', 'u', 'i', 'em', 'p']
    self.before.insert (userId, doc) ->
      for arg in args
        doc[arg] = sanitizeHtml doc[arg],
          allowedTags: allowed
    self.before.update (userId, doc, fieldNames, modifier, options) ->
      doc = modifier.$set
      for arg in args
        doc[arg] = sanitizeHtml doc[arg],
          allowedTags: allowed