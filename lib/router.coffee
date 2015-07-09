FlowRouter.route '/',
  name: 'home'
  subscriptions: (params, queryParams) ->
    if _.isNaN parseInt(queryParams.page)
      FlowRouter.setQueryParams page: 0
    page = parseInt(queryParams.page) or 0
    limit = 3
    offset = page*limit
    this.register('postsWithSkip', Meteor.subscribe('postsWithSkip', offset, limit))
    lang = queryParams.lang or 'en'
    this.register('i18n', Meteor.subscribe("i18n", lang))
  action: (params, queryParams) ->
    FlowLayout.render 'mainLayout', {top: 'header', main: 'home'}

FlowRouter.route '/log-in/',
  action: (params, queryParams) ->
    FlowLayout.render 'mainLayout', {top: 'header', main: 'log-in'}
  name: 'log-in'
  subscriptions: (params, queryParams) ->
    lang = queryParams.lang or 'en'
    this.register('i18n', Meteor.subscribe("i18n", lang))

loginTrigger = (context, redirect) ->
  if not Meteor.userId()
    redirect('log-in')

FlowRouter.triggers.enter([loginTrigger], {except: ["log-in"]})