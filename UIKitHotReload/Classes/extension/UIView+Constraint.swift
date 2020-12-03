//
//  UIView+Constraint.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

extension UIView {

  func edgesEqual(to: UILayoutGuide, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {

    let margin = margin ?? .allDefault
    let reverse: CGFloat = isReverseMargin ? -1.0 : 1.0

    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    if !(margin.top?.remove ?? false) {
      let top = self.topAnchor.constraint(equalTo: to.topAnchor, constant: margin.top?.value ?? 0.0)
      top.priority = margin.top?.priority ?? .required
      constraints.append(top)
    }

    if !(margin.leading?.remove ?? false) {
      let leading = self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: margin.leading?.value ?? 0.0)
      leading.priority = margin.leading?.priority ?? .required
      constraints.append(leading)
    }

    if !(margin.trailing?.remove ?? false) {
      let trailing = to.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: reverse * (margin.trailing?.value ?? 0.0))
      trailing.priority = margin.trailing?.priority ?? .required
      constraints.append(trailing)
    }

    if !(margin.bottom?.remove ?? false) {
      let bottom = to.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: reverse * (margin.bottom?.value ?? 0.0))
      bottom.priority = margin.bottom?.priority ?? .required
      constraints.append(bottom)
    }

    NSLayoutConstraint.activate(constraints)
  }

  func edgesEqual(to: UIView, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {

    let margin = margin ?? .allDefault
    let reverse: CGFloat = isReverseMargin ? -1.0 : 1.0

    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    let top = self.topAnchor.constraint(equalTo: to.topAnchor, constant: margin.top?.value ?? 0.0)
    top.priority = margin.top?.priority ?? .required
    constraints.append(top)

    let leading = self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: margin.leading?.value ?? 0.0)
    leading.priority = margin.leading?.priority ?? .required
    constraints.append(leading)

    let trailing = to.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: reverse * (margin.trailing?.value ?? 0.0))
    trailing.priority = margin.trailing?.priority ?? .required
    constraints.append(trailing)

    let bottom = to.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: reverse * (margin.bottom?.value ?? 0.0))
    bottom.priority = margin.bottom?.priority ?? .required
    constraints.append(bottom)

    NSLayoutConstraint.activate(constraints)
  }

  func edgesEqual(to view: UIView, isSafeArea: Bool = true, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {
    if isSafeArea {
      edgesEqual(to: view.safeAreaLayoutGuide, margin: margin)
    } else {
      edgesEqual(to: view, margin: margin)
    }
  }

  func edgesEqualToSuperView(isSafeArea: Bool = true, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {
    guard let _superview = superview else { return }
    self.edgesEqual(to: _superview, isSafeArea: isSafeArea, margin: margin)
  }
}

extension UIView {

  func positionSet(to: UILayoutGuide, position: LayoutModel.EdgeModel) {
    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    if let vp = position.top {
      let constraint = self.topAnchor.constraint(equalTo: to.topAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.leading {
      let constraint = self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.leading {
      let constraint = self.trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.bottom {
      let constraint = self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    NSLayoutConstraint.activate(constraints)
  }

  func positionSet(to: UIView, position: LayoutModel.EdgeModel) {
    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    if let vp = position.top {
      let constraint = self.topAnchor.constraint(equalTo: to.topAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.leading {
      let constraint = self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.trailing {
      let constraint = to.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    if let vp = position.bottom {
      let constraint = to.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: vp.value)
      constraint.priority = vp.priority
      constraints.append(constraint)
    }

    NSLayoutConstraint.activate(constraints)
  }

  func positionSet(to view: UIView, isSafeArea: Bool = true, position: LayoutModel.EdgeModel) {
    if isSafeArea {
      positionSet(to: view.safeAreaLayoutGuide, position: position)
    } else {
      positionSet(to: view, position: position)
    }
  }

  func positionSetToSuperView(isSafeArea: Bool = true, position: LayoutModel.EdgeModel) {
    guard let _superview = superview else { return }
    positionSet(to: _superview, isSafeArea: isSafeArea, position: position)
  }
}

extension UIView {

  func centerXEqual(to: UILayoutGuide, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func centerXEqual(to: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func centerXEqual(to view: UIView, isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    if isSafeArea {
      centerXEqual(to: view.safeAreaLayoutGuide, constant: constant, priority: priority)
    } else {
      centerXEqual(to: view, constant: constant, priority: priority)
    }
  }

  func centerXEqualToSuperView(isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    centerXEqual(to: _superview, isSafeArea: isSafeArea, constant: constant, priority: priority)
  }
}

extension UIView {

  func centerYEqual(to: UILayoutGuide, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func centerYEqual(to: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func centerYEqual(to view: UIView, isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    if isSafeArea {
      centerYEqual(to: view.safeAreaLayoutGuide, constant: constant, priority: priority)
    } else {
      centerYEqual(to: view, constant: constant, priority: priority)
    }
  }

  func centerYEqualToSuperView(isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    centerYEqual(to: _superview, isSafeArea: isSafeArea, constant: constant, priority: priority)
  }
}

extension UIView {

  func widthEqual(to: UILayoutGuide, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func widthEqual(to: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func widthEqual(to view: UIView, isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    if isSafeArea {
      widthEqual(to: view.safeAreaLayoutGuide, constant: constant, priority: priority)
    } else {
      widthEqual(to: view, constant: constant, priority: priority)
    }
  }

  func widthEqualToSuperView(isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    widthEqual(to: _superview, isSafeArea: isSafeArea, constant: constant, priority: priority)
  }

  func widthEqual(constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.widthAnchor.constraint(equalToConstant: constant)
    c.priority = priority
    c.isActive = true
  }
}

extension UIView {

  func heightEqual(to: UILayoutGuide, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func heightEqual(to: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant)
    c.priority = priority
    c.isActive = true
  }

  func heightEqual(to view: UIView, isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    if isSafeArea {
      heightEqual(to: view.safeAreaLayoutGuide, constant: constant, priority: priority)
    } else {
      heightEqual(to: view, constant: constant, priority: priority)
    }
  }

  func heightEqualToSuperView(isSafeArea: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    heightEqual(to: _superview, isSafeArea: isSafeArea, constant: constant, priority: priority)
  }

  func heightEqual(constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.heightAnchor.constraint(equalToConstant: constant)
    c.priority = priority
    c.isActive = true
  }
}

extension UIView {
  func aspectRatio(_ aspectRatio: CGFloat, priority: UILayoutPriority = .required, isSetWidth: Bool = true) {
    self.translatesAutoresizingMaskIntoConstraints = false
    if isSetWidth {
      let c = self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: aspectRatio)
      c.priority = priority
      c.isActive = true
    } else {
      let c = self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: aspectRatio)
      c.priority = priority
      c.isActive = true
    }
  }
}
