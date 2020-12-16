//
//  LayoutDimension.swift
//  SangeuiLayout
//
//  Created by 서상의 on 2020/12/15.
//

import UIKit

public protocol LayoutDimension: LayoutAnchor {
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
