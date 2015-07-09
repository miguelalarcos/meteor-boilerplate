class @Login extends sb.Model
  @schema:
    email:
      type: String
    password:
      type: String
    visible:
      type: Boolean
  #setVisible: -> @visible = not @visible
  login: -> Meteor.loginWithPassword @email, @password, (error, result) ->
    if not error
      FlowRouter.go('admin-post')
    else
      sAlert.error('Error! ' + error.reason, {position: 'top-right', timeout: 5000})

class @Account extends sb.Model
  @schema:
    username:
      type: String
    email:
      type: String
    password:
      type: String
    passwordRepeat:
      type: String
      validation: (x, self) -> self.password == self.passwordRepeat
    visible:
      type: Boolean
  #setVisible: -> @visible = not @visible
  createAccount: -> Accounts.createUser {username: @username, email: @email, password: @password}, (error) ->
    if not error
      FlowRouter.go 'admin-post'
    else
      sAlert.error('Error! ' + error.reason, {position: 'top-right', timeout: 5000})

class Access extends sb.Model
  @schema:
    login:
      type: Login
    register:
      type: Account
  setVisible1: ->
    @login.visible = true
    @register.visible = false
  setVisible2: ->
    @login.visible = false
    @register.visible = true

Template['log-in'].helpers
  #loginModel: -> new Login {}
  #registerModel: -> new Account {}
  accessModel: -> new Access {}