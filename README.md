
## 👨🏽‍💻 SangeuiLayout

**❌It doesn't support any layout guide yet❌**

My own version of DSL for AutoLayout.
It is made for me to use AutoLayout codes more easily.

---

You can lay your view out as follows
```swift
import SangeuiLayout

let view = UIView()
view.layout(using: { proxy in
    proxy.height.equal(toConstant: 20)
    proxy.widtgh.equal(toConstant: 20)
})
```

`layout(using:)` method make your view to use AutoLayout, so you don't need to set `translatesAutoresizingMaskIntoConstraints` directly. 

If you want to add your view into other view
```swift
...
view.layout(using: { proxy in 
    proxy.becomeChild(of: otherView)
})
```

As a result, some verbose AutoLayout lines of code can be reduced and more readable.
```swift
// From
let parentView = UIView()
let view = UIView()

parentView.addSubview(view)
view.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
    view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
    view.topAnchor.constraint(equalTo: parentView.topAnchor),
    view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
])

// To
let parentView = UIView()
let view = UIView()

view.layout(using: { proxy in 
    proxy.becomeChild(of parentView)
    proxy.leading.equal(to: parentView.leading)
    proxy.trailing.equal(to: parentView.trailing)
    proxy.top.equal(to: parentView.top)
    proxy.bottom.equal(to: parentView.bottom)
})

```
