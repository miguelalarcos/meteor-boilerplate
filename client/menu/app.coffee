#Template.smenu.helpers
#  template: -> 'menu'

Template.menu.helpers
  isPhone: ->
    if Meteor.Device.isPhone()
      'is-phone'
    else
      ''
Template.body.events
  'click .show': (e,t) ->
    $('.menu.first').addClass('active')
