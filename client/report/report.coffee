Template.report.helpers
  data: ->
    postId = FlowRouter.getQueryParam('postId')
    model = new Post posts.findOne(postId)
    report = reports.findOne({})
    {title: report.title, content: Spacebars.toHTML(model, report.content)}
  ready: -> FlowRouter.subsReady('postById') and FlowRouter.subsReady('reports')

#server/init.coffee:
#reports.remove({})
#content = "
#<h1>{{title}}</h1>
#{{{text}}}
#"
#reports.insert(title: 'first report' , content: content)