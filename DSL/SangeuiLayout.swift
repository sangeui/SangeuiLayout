//
//  SangeuiLayout.swift
//  SangeuiLayout
//
//  Created by 서상의 on 2020/12/03.
//

import UIKit


import UIKit

enum StretchDirection {
    case vertical, horizontal, both
}
// MARK: - Domain Specific Language for AutoLayout
protocol LayoutAnchor {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}
protocol LayoutDimension: LayoutAnchor {
    func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
    
    func constraint(equalTo anchor: Self, multiplier: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat) -> NSLayoutConstraint
    
    func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

class LayoutAnchorProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
    init(anchor: Anchor) { self.anchor = anchor }
}
class LayoutDimensionProperty<Dimension: LayoutDimension>: LayoutAnchorProperty<Dimension> {
    init(dimension: Dimension) {
        super.init(anchor: dimension)
    }
}
public class LayoutProxy {
    lazy var leading = anchor(with: view.leadingAnchor)
    lazy var trailing = anchor(with: view.trailingAnchor)
    lazy var top = anchor(with: view.topAnchor)
    lazy var bottom = anchor(with: view.bottomAnchor)
    lazy var centerX = anchor(with: view.centerXAnchor)
    lazy var centerY = anchor(with: view.centerYAnchor)
    
    lazy var width = dimension(with: view.widthAnchor) 
    lazy var height = dimension(with: view.heightAnchor)
    
    private let view: UIView
    
    fileprivate init(view: UIView) {
        self.view = view
    }
    private func anchor<A: LayoutAnchor>(with anchor: A) -> LayoutAnchorProperty<A> {
        return LayoutAnchorProperty(anchor: anchor)
    }
    private func dimension<D: LayoutDimension>(with dimension: D) -> LayoutDimensionProperty<D> {
        return LayoutDimensionProperty(dimension: dimension)
    }
}
extension LayoutProxy {
    func becomeChild(of view: UIView) {
        view.addSubview(self.view)
    }
    func stretch(like target: UIView,padding: CGFloat = 0, direction: StretchDirection) {
        switch direction {
        case .horizontal:
            self.leading.equal(to: target.leadingAnchor, offsetBy: padding)
            self.trailing.equal(to: target.trailingAnchor, offsetBy: -padding)
        case .vertical:
            self.top.equal(to: target.topAnchor, offsetBy: padding)
            self.bottom.equal(to: target.bottomAnchor, offsetBy: -padding)
        case .both:
            self.leading.equal(to: target.leadingAnchor, offsetBy: padding)
            self.trailing.equal(to: target.trailingAnchor, offsetBy: -padding)
            self.top.equal(to: target.topAnchor, offsetBy: padding)
            self.bottom.equal(to: target.bottomAnchor, offsetBy: -padding)
        }
    }
    func pin<Anchor: LayoutAnchor>(_ anchor: LayoutAnchorProperty<Anchor>,
                                   targetAnchor: Anchor) {
        anchor.equal(to: targetAnchor)
    }
}
extension LayoutAnchorProperty {
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}
extension LayoutDimensionProperty {
    func equal(toConstant c: CGFloat, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(equalToConstant: c)
        constraint.priority = priority
        constraint.isActive = true
    }
    func greaterThanOrEqual(toConstant c: CGFloat, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(greaterThanOrEqualToConstant: c)
        constraint.priority = priority
        constraint.isActive = true
    }
    func lessThanOrEqual(toConstant c: CGFloat, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(lessThanOrEqualToConstant: c)
        constraint.priority = priority
        constraint.isActive = true
    }
    func equal(to otherAnchor: Dimension, multiplier: CGFloat = 1, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(equalTo: otherAnchor, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    func greaterThanOrEqual(to otherAnchor: Dimension, multiplier: CGFloat, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    func lessThanOrEqual(to otherAnchor: Dimension, multiplier: CGFloat, offsetBy constant: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}
public extension UIView {
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
}
