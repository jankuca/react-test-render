reactTestUtils = require 'react-addons-test-utils'

TestRenderer = require './test-renderer'


createRenderer = (Component, context = null) ->
  shallowRenderer = createShallowRenderer()
  testRenderer = new TestRenderer(shallowRenderer, Component, context)
  return testRenderer


createShallowRenderer = ->
  shallowRenderer = reactTestUtils.createRenderer()
  renderInternal = shallowRenderer._render

  # TEMP: `ReactShallowRenderer` does not call all lifecycle methods – namely
  #   `componentDidMount` and `componentDidUpdate`. This patch fixes this until
  #   real support lands in the official React codebase.
  shallowRenderer._render = (element, transaction, context) ->
    # NOTE: This condition disables the patch when React implements the desired
    #   behavior. The transaction will be in progress then.
    if transaction.isInTransaction()
      return renderInternal()

    transaction.perform(renderInternal, this, element, transaction, context)

  return shallowRenderer


module.exports = {
  TestRenderer
  createRenderer
}
