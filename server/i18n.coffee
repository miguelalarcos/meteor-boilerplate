Meteor.startup ->
  yaml_text = Assets.getText('i18n_map.yaml')
  map = YAML.safeLoad(yaml_text)
  i18n_map(map)
