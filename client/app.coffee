Tracker.autorun ->
  if not Meteor.userId()
    FlowRouter.go('log-in')

Template.language.events
  'click .language': (e, t) ->
    lang = $(e.target).attr('lang')
    FlowRouter.setQueryParams({lang: lang})

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout()

Template.mainLayout.helpers
  ready: -> FlowRouter.subsReady('i18n')