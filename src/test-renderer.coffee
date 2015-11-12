shallowTestUtils = require 'react-shallow-testutils'

{ flattenChildren } = require './utils'


class TestRenderer
  constructor: (shallowRenderer, Component, context) ->
    @_shallowRenderer = shallowRenderer
    @_Component = Component
    @_context = context

  render: (props = {}) ->
    element = react.createElement(@_Component, props)
    @_renderer.render(element, @_context)
    return @getRendering()

  getRendering: ->
    return @_renderer.getRenderOutput()

  getChildren: (parent = @getRendering()) ->
    return flattenChildren(parent.props.children)

  getChildOfType: (type, parent = @getRendering()) ->
    try
      return shallowTestUtils.findWithType(@getRendering(), type)
    catch error
      return null

  getChildrenOfType: (type, parent = @getRendering()) ->
    return shallowTestUtils.findAllWithType(@getRendering(), type)

  getChildOfClass: (className, parent = @getRendering()) ->
    try
      return shallowTestUtils.findWithClass(@getRendering(), className)
    catch error
      return null

  getChildrenOfClass: (className, parent = @getRendering()) ->
    return shallowTestUtils.findAllWithClass(@getRendering(), className)

  getTextContent: (parent = @getRendering()) ->
    children = @getChildren(parent)
    textContent = ''

    children.forEach (child) =>
      if typeof child == 'string'
        textContent += child
      else
        textContent += @getTextContent(child)

    return textContent


module.exports = TestRenderer
