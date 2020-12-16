//
//  LayoutAnchor.swift
//  SangeuiLayout
//
//  Created by 서상의 on 2020/12/15.
//

import UIKit

public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}
