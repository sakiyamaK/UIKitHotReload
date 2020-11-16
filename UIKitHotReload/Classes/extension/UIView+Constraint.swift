//
//  UIView+Constraint.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public extension UIView {

  func edgesEqual(to: UILayoutGuide, margin: UIEdgeInsets = .zero, priorities: UIEdgePriorities = .init()) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      self.topAnchor.constraint(equalTo: to.topAnchor, constant: margin.top),
      self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: margin.left),
      to.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: margin.right),
      to.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: margin.bottom)
    ]
    constraints[0].priority = priorities.top
    constraints[1].priority = priorities.leading
    constraints[2].priority = priorities.trailing
    constraints[3].priority = priorities.bottom

    NSLayoutConstraint.activate(constraints)
  }

  func edgesEqual(to: UIView, margin: UIEdgeInsets = .zero, priorities: UIEdgePriorities = .init()) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      self.topAnchor.constraint(equalTo: to.topAnchor, constant: margin.top),
      self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: margin.left),
      to.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: margin.right),
      to.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: margin.bottom)
    ]
    constraints[0].priority = priorities.top
    constraints[1].priority = priorities.leading
    constraints[2].priority = priorities.trailing
    constraints[3].priority = priorities.bottom

    NSLayoutConstraint.activate(constraints)
  }

  func edgesEqualToSafeArea(_ view: UIView, margin: UIEdgeInsets = .zero, priorities: UIEdgePriorities = .init()) {
    edgesEqual(to: view.safeAreaLayoutGuide, margin: margin, priorities: priorities)
  }

  func edgesEqualToSuperViewSafeArea(margin: UIEdgeInsets = .zero, priorities: UIEdgePriorities = .init()) {
    guard let _superview = superview else { return }
    edgesEqual(to: _superview.safeAreaLayoutGuide, margin: margin, priorities: priorities)
  }

  func edgesEqualToSuperView(margin: UIEdgeInsets = .zero, priorities: UIEdgePriorities = .init()) {
    guard let _superview = superview else { return }
    self.edgesEqual(to: _superview, margin: margin, priorities: priorities)
  }
}

public extension UIView {
  func centerXEqual(to: UILayoutGuide, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: constant).isActive = true
  }

  func centerYEqual(to: UILayoutGuide, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: constant).isActive = true
  }

  func widthEqual(to: UILayoutGuide, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant).isActive = true
  }

  func heightEqual(to: UILayoutGuide, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant).isActive = true
  }

  func centerXEqual(to: UIView, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: constant).isActive = true
  }

  func centerYEqual(to: UIView, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: constant).isActive = true
  }

  func widthEqual(to: UIView, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant).isActive = true
  }

  func heightEqual(to: UIView, constant: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant).isActive = true
  }

  func centerXEqualToSuperView(constant: CGFloat = 0) {
    guard let _superview = superview else { return }
    centerXEqual(to: _superview, constant: constant)
  }

  func centerYEqualToSuperView(constant: CGFloat = 0) {
    guard let _superview = superview else { return }
    centerYEqual(to: _superview, constant: constant)
  }

  func widthEqualToSuperView(constant: CGFloat = 0) {
    guard let _superview = superview else { return }
    widthEqual(to: _superview, constant: constant)
  }

  func heightEqualToSuperView(constant: CGFloat = 0) {
    guard let _superview = superview else { return }
    heightEqual(to: _superview, constant: constant)
  }
}
