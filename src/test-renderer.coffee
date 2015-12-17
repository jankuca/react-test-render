React = require 'react'
shallowTestUtils = require 'react-shallow-testutils'

{ flattenChildren } = require './utils'


class TestRenderer
  constructor: (shallowRenderer, Component, context) ->
    @_shallowRenderer = shallowRenderer
    @_Component = Component
    @_context = context
    @_lastProps = {}

  setContext: (contextUpdate = {}) ->
    nextContext = {}
    for contextKey, value of @_context
      nextContext[contextKey] = value
    for contextKey, value of contextUpdate
      nextContext[contextKey] = value

    @_context = nextContext
    @render(@_lastProps)

  render: (props = {}) ->
    @_lastProps = props
    element = React.createElement(@_Component, props)
    @_shallowRenderer.render(element, @_context)
    return @getRendering()

  getRendering: ->
    return @_shallowRenderer.getRenderOutput()

  getComponent: ->
    # TEMP: React 0.14.2 does not implement #getMountedInstance()
    if !@_shallowRenderer.getMountedInstance
      return @_shallowRenderer._instance?._instance or null

    return @_shallowRenderer.getMountedInstance()

  getChildContext: ->
    component = @getComponent()
    return component.getChildContext()

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
