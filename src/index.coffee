reactTestUtils = require 'react-addons-test-utils'

TestRenderer = require './test-renderer'


createRenderer = (Component, context = null) ->
  shallowRenderer = reactTestUtils.createRenderer()
  testRenderer = new TestRenderer(shallowRenderer, Component, context)
  return testRenderer


module.exports = {
  TestRenderer
  createRenderer
}
