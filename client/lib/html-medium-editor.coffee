Template.htmlMediumEditor.onRendered ->
  el = this.$('.editable')
  new MediumEditor(el, {placeholder: false})