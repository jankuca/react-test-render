# React Test Render Utils


## Example Usage

```
import { createRenderer } from 'react-test-render'
import MyComponent from './my-component'
import MyComponentItem from './my-component-item'

test(() => {
  const serviceAbc = new ServiceAbc()
  const renderer = reactTestRender.createRenderer(MyComponent, {
    serviceAbc
  })

  let myComponent = renderer.render({ x: 123 })
  expect(myComponent.props.x).to.be(123)

  serviceAbc.setItemsInTest([ 1, 2, 3 ])
  let itemComponents = renderer.getChildrenOfType(MyComponentItem)
  expect(itemComponents).to.have.length(3)
})
```

## API

```
reactTestRender.createRenderer(ComponentType, context) -> TestRenderer

# Rerenders and returns the current rendering.
TestRenderer#render(props) -> Component

# Returns the current rendering without rerendering.
TestRenderer#getRendering() -> Component

# Collects the children of the provided component or the root one.
TestRenderer#getChildren(parentComponent) -> [ Component ]
TestRenderer#getChildren() -> [ Component ]
TestRenderer#getChildrenOfType(ComponentType, parentComponent) -> [ Component ]
TestRenderer#getChildrenOfType(tagName, parentComponent) -> [ Component ]
TestRenderer#getChildrenOfType(ComponentType) -> [ Component ]
TestRenderer#getChildrenOfType(tagName) -> [ Component ]
TestRenderer#getChildrenOfClass(className, parentComponent) -> [ Component ]
TestRenderer#getChildrenOfClass(className) -> [ Component ]

# Returns the first child component if present
TestRenderer#getChildOfType(ComponentType, parentComponent) -> Component | null
TestRenderer#getChildOfType(tagName, parentComponent) -> Component | null
TestRenderer#getChildOfType(ComponentType) -> Component | null
TestRenderer#getChildOfType(tagName) -> Component | null
TestRenderer#getChildOfClass(className, parentComponent) -> Component | null
TestRenderer#getChildOfClass(className) -> Component | null

# Returns the whole text content of the provided component or the root one.
TestRenderer#getTextContent(component) -> string
TestRenderer#getTextContent() -> string
```
