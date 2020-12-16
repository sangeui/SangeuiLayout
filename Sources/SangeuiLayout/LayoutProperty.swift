//
//  LayoutAnchorProperty.swift
//  SangeuiLayout
//
//  Created by 서상의 on 2020/12/16.
//

import UIKit

public class LayoutGuideProperty<Guide: UILayoutGuide> {
    fileprivate let guide: Guide
    init(guide: Guide) { self.guide = guide }
    
    public lazy var leading = LayoutAnchorProperty(anchor: guide.leadingAnchor)
    public lazy var trailing = LayoutAnchorProperty(anchor: guide.trailingAnchor)
    public lazy var top = LayoutAnchorProperty(anchor: guide.topAnchor)
    public lazy var bottom = LayoutAnchorProperty(anchor: guide.bottomAnchor)
    public lazy var centerX = LayoutAnchorProperty(anchor: guide.centerXAnchor)
    public lazy var centerY = LayoutAnchorProperty(anchor: guide.centerYAnchor)
    public lazy var width = LayoutAnchorProperty(anchor: guide.widthAnchor)
    public lazy var height = LayoutAnchorProperty(anchor: guide.heightAnchor)
}
public extension LayoutGuideProperty {
}
public class LayoutDimensionProperty<Dimension: LayoutDimension>: LayoutAnchorProperty<Dimension> {
    init(dimension: Dimension) { super.init(anchor: dimension) }
}
public extension LayoutDimensionProperty {
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

public class LayoutAnchorProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
    init(anchor: Anchor) { self.anchor = anchor }
}
public extension LayoutAnchorProperty {
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
