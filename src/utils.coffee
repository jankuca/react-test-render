_ = require 'lodash'
immutable = require 'immutable'


flatMap = _.flowRight([ _.flatten, _.map ])


flattenChildren = (children) ->
  if Array.isArray(children)
    return flatMap(children, flattenChildren)

  if immutable.List.isList(children)
    return children.flatMap(flattenChildren).toArray()

  if children
    return [ children ]

  return []


module.exports = {
  flatMap
  flattenChildren
}
