Template.report.helpers
  data: ->
    postId = FlowRouter.getQueryParam('postId')
    model = new Post posts.findOne(postId)
    report = reports.findOne({})
    {title: report.title, content: Spacebars.toHTML(model, report.content)}
  ready: -> FlowRouter.subsReady('postById') and FlowRouter.subsReady('reports')