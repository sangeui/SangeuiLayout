
## 👨🏽‍💻 SangeuiLayout

My own version of DSL for AutoLayout.
It is made for me to use AutoLayout codes more easily.

---

You can lay your view out as follows
```swift
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
