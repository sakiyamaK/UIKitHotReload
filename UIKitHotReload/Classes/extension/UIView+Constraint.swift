//
//  UIView+Constraint.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

protocol LayoutGuideProtocol {
  var topAnchorHR: NSLayoutYAxisAnchor { get }
  var leadingAnchorHR: NSLayoutXAxisAnchor { get }
  var bottomAnchorHR: NSLayoutYAxisAnchor { get }
  var trailingAnchorHR: NSLayoutXAxisAnchor { get }
  var centerXAnchorHR: NSLayoutXAxisAnchor { get }
  var centerYAnchorHR: NSLayoutYAxisAnchor { get }
  var widthAnchorHR: NSLayoutDimension { get }
  var heightAnchorHR: NSLayoutDimension { get }
}

extension UIView: LayoutGuideProtocol {
  var topAnchorHR: NSLayoutYAxisAnchor { self.topAnchor }
  var leadingAnchorHR: NSLayoutXAxisAnchor { self.leadingAnchor }
  var bottomAnchorHR: NSLayoutYAxisAnchor { self.bottomAnchor }
  var trailingAnchorHR: NSLayoutXAxisAnchor { self.trailingAnchor }
  var centerXAnchorHR: NSLayoutXAxisAnchor { self.centerXAnchor }
  var centerYAnchorHR: NSLayoutYAxisAnchor { self.centerYAnchor }
  var widthAnchorHR: NSLayoutDimension { self.widthAnchor }
  var heightAnchorHR: NSLayoutDimension { self.heightAnchor }
}

extension UILayoutGuide: LayoutGuideProtocol {
  var topAnchorHR: NSLayoutYAxisAnchor { self.topAnchor }
  var leadingAnchorHR: NSLayoutXAxisAnchor { self.leadingAnchor }
  var bottomAnchorHR: NSLayoutYAxisAnchor { self.bottomAnchor }
  var trailingAnchorHR: NSLayoutXAxisAnchor { self.trailingAnchor }
  var centerXAnchorHR: NSLayoutXAxisAnchor { self.centerXAnchor }
  var centerYAnchorHR: NSLayoutYAxisAnchor { self.centerYAnchor }
  var widthAnchorHR: NSLayoutDimension { self.widthAnchor }
  var heightAnchorHR: NSLayoutDimension { self.heightAnchor }
}

extension UIView {

  func edgesEqual(to: LayoutGuideProtocol, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {

    let margin = margin ?? .allDefault
    let reverse: CGFloat = isReverseMargin ? -1.0 : 1.0

    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    if !(margin.top?.remove ?? false) {
      let top = self.topAnchor.constraint(equalTo: to.topAnchorHR, constant: margin.top?.value ?? 0.0)
      top.identifier = margin.top?.id
      top.priority = margin.top?.priority ?? .required
      top.isActive = margin.top?.active ?? true
      constraints.append(top)
    }

    if !(margin.leading?.remove ?? false) {
      let leading = self.leadingAnchor.constraint(equalTo: to.leadingAnchorHR, constant: margin.leading?.value ?? 0.0)
      leading.identifier = margin.top?.id
      leading.priority = margin.leading?.priority ?? .required
      leading.isActive = margin.leading?.active ?? true
      constraints.append(leading)
    }

    if !(margin.trailing?.remove ?? false) {
      let trailing = to.trailingAnchorHR.constraint(equalTo: self.trailingAnchor, constant: reverse * (margin.trailing?.value ?? 0.0))
      trailing.identifier = margin.top?.id
      trailing.priority = margin.trailing?.priority ?? .required
      trailing.isActive = margin.trailing?.active ?? true
      constraints.append(trailing)
    }

    if !(margin.bottom?.remove ?? false) {
      let bottom = to.bottomAnchorHR.constraint(equalTo: self.bottomAnchor, constant: reverse * (margin.bottom?.value ?? 0.0))
      bottom.identifier = margin.top?.id
      bottom.priority = margin.bottom?.priority ?? .required
      bottom.isActive = margin.bottom?.active ?? true
      constraints.append(bottom)
    }

    NSLayoutConstraint.activate(constraints.filter{$0.isActive})
  }

  func edgesEqual(to view: UIView, isSafeArea: Bool = true, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    edgesEqual(to: to, margin: margin, isReverseMargin: isReverseMargin)
  }

  func edgesEqualToSuperView(isSafeArea: Bool = true, margin: LayoutModel.EdgeModel? = nil, isReverseMargin: Bool = false) {
    guard let _superview = superview else { return }
    self.edgesEqual(to: _superview, isSafeArea: isSafeArea, margin: margin)
  }
}

extension UIView {

  func positionSet(to: LayoutGuideProtocol, position: LayoutModel.EdgeModel) {
    self.translatesAutoresizingMaskIntoConstraints = false

    var constraints: [NSLayoutConstraint] = []

    if let vp = position.top {
      let constraint = self.topAnchor.constraint(equalTo: to.topAnchorHR, constant: vp.value)
      constraint.identifier = vp.id
      constraint.priority = vp.priority
      constraint.isActive = vp.active
      constraints.append(constraint)
    }

    if let vp = position.leading {
      let constraint = self.leadingAnchor.constraint(equalTo: to.leadingAnchorHR, constant: vp.value)
      constraint.identifier = vp.id
      constraint.priority = vp.priority
      constraint.isActive = vp.active
      constraints.append(constraint)
    }

    if let vp = position.trailing {
      let constraint = self.trailingAnchor.constraint(equalTo: to.trailingAnchorHR, constant: vp.value)
      constraint.identifier = vp.id
      constraint.priority = vp.priority
      constraint.isActive = vp.active
      constraints.append(constraint)
    }

    if let vp = position.bottom {
      let constraint = self.bottomAnchor.constraint(equalTo: to.bottomAnchorHR, constant: vp.value)
      constraint.identifier = vp.id
      constraint.priority = vp.priority
      constraint.isActive = vp.active
      constraints.append(constraint)
    }

    NSLayoutConstraint.activate(constraints.filter{$0.isActive})
  }

  func positionSet(to view: UIView, isSafeArea: Bool = true, position: LayoutModel.EdgeModel) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    positionSet(to: to, position: position)
  }

  func positionSetToSuperView(isSafeArea: Bool = true, position: LayoutModel.EdgeModel) {
    guard let _superview = superview else { return }
    positionSet(to: _superview, isSafeArea: isSafeArea, position: position)
  }
}

extension UIView {

  func centerXEqual(to: LayoutGuideProtocol, id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerXAnchor.constraint(equalTo: to.centerXAnchorHR, constant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }

  func centerXEqual(to view: UIView, id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    centerXEqual(to: to, id: id, isActive: isActive, constant: constant, priority: priority)
  }

  func centerXEqualToSuperView(id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    centerXEqual(to: _superview, id: id, isSafeArea: isSafeArea, isActive: isActive, constant: constant, priority: priority)
  }
}

extension UIView {

  func centerYEqual(to: LayoutGuideProtocol, id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.centerYAnchor.constraint(equalTo: to.centerYAnchorHR, constant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }

  func centerYEqual(to view: UIView, id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    centerYEqual(to: to, id: id, isActive: isActive, constant: constant, priority: priority)
  }

  func centerYEqualToSuperView(id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    centerYEqual(to: _superview, id: id, isSafeArea: isSafeArea, isActive: isActive, constant: constant, priority: priority)
  }
}

extension UIView {

  func widthEqual(to: LayoutGuideProtocol, id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.widthAnchor.constraint(equalTo: to.widthAnchorHR, constant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }

  func widthEqual(to view: UIView, id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    widthEqual(to: to, id: id, isActive: isActive, constant: constant, priority: priority)
  }

  func widthEqualToSuperView(id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    widthEqual(to: _superview, id: id, isSafeArea: isSafeArea, isActive: isActive, constant: constant, priority: priority)
  }

  func widthEqual(id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.widthAnchor.constraint(equalToConstant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }
}

extension UIView {

  func heightEqual(to: LayoutGuideProtocol, id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.heightAnchor.constraint(equalTo: to.heightAnchorHR, constant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }

  func heightEqual(to view: UIView, id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    let to: LayoutGuideProtocol = isSafeArea ? view.safeAreaLayoutGuide : view
    heightEqual(to: to, id: id, isActive: isActive, constant: constant, priority: priority)
  }

  func heightEqualToSuperView(id: String? = nil, isSafeArea: Bool = true, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    guard let _superview = superview else { return }
    heightEqual(to: _superview, id: id, isSafeArea: isSafeArea, isActive: isActive, constant: constant, priority: priority)
  }

  func heightEqual(id: String? = nil, isActive: Bool = true, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let c = self.heightAnchor.constraint(equalToConstant: constant)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }
}

extension UIView {
  func aspectRatio(id: String? = nil, isActive: Bool = true, aspectRatio: CGFloat, priority: UILayoutPriority = .required, isSetWidth: Bool = true) {
    self.translatesAutoresizingMaskIntoConstraints = false
    let anchor = isSetWidth ? self.heightAnchor : self.widthAnchor
    let c = anchor.constraint(equalTo: self.widthAnchor, multiplier: aspectRatio)
    c.identifier = id
    c.priority = priority
    c.isActive = isActive
  }
}
