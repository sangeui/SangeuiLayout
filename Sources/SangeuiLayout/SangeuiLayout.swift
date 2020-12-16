import UIKit

// MARK: - Domain Specific Language for AutoLayout

extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

public class LayoutProxy {
    public lazy var leading = anchor(with: view.leadingAnchor)
    public lazy var trailing = anchor(with: view.trailingAnchor)
    public lazy var top = anchor(with: view.topAnchor)
    public lazy var bottom = anchor(with: view.bottomAnchor)
    public lazy var centerX = anchor(with: view.centerXAnchor)
    public lazy var centerY = anchor(with: view.centerYAnchor)
    
    public lazy var width = dimension(with: view.widthAnchor)
    public lazy var height = dimension(with: view.heightAnchor)
    
    @available(iOS 11.0, *)
    public lazy var safearea = LayoutGuideProperty(guide: view.safeAreaLayoutGuide)
    public lazy var layoutmargins = LayoutGuideProperty(guide: view.layoutMarginsGuide)
    
    private let view: UIView
    
    fileprivate init(view: UIView) {
        print(view)
        self.view = view
    }
    private func anchor<A: LayoutAnchor>(with anchor: A) -> LayoutAnchorProperty<A> {
        
        return LayoutAnchorProperty(anchor: anchor)
    }
    private func dimension<D: LayoutDimension>(with dimension: D) -> LayoutDimensionProperty<D> {
        return LayoutDimensionProperty(dimension: dimension)
    }
}
public extension LayoutProxy {
    func becomeChild(of view: UIView) { view.addSubview(self.view) }
}

public extension UIView {
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
}

class Test {
    func test() {
        UIView().layout(using: { proxy in
        })
        UIScrollView().layout(using: { proxy in
        })
    }
}
