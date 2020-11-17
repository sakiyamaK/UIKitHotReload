//
//  UIView+.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/10.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

private let db = Firestore.firestore()

public extension UIView {
  func loadHotReload(documentRef: DocumentReference, snapshot: Bool = true, completion: ((Error?) -> Void)? = nil) {
    documentRef.addSnapshotListener { (docSnapshot, err) in
      if let _err = err {
        print("Error getting documents: \(_err)")
        completion?(_err)
        return
      }

      guard
        let data = docSnapshot?.data() else {
        let error = NSError.init(domain: "no data", code: 100, userInfo: nil)
        completion?(error)
        return
      }

      do {
        let viewModel = try Firestore.Decoder().decode(RootViewModel.self, from: data)
        guard let view = viewModel.view else {
          let error = NSError.init(domain: "no view", code: 110, userInfo: nil)
          completion?(error)
          return
        }

        self.subviews.filter { $0.accessibilityIdentifier == view.accessibilityIdentifier }.first?.removeFromSuperview()
        self.addSubview(view)
        if viewModel.isSafeArea {
          view.edgesEqualToSuperViewSafeArea()
        } else {
          view.edgesEqualToSuperView()
        }
        completion?(nil)
      } catch(let error) {
        completion?(error)
      }
    }
  }

  func loadHotReload(collectionName: String, documentName: String, snapshot: Bool = true, completion: ((Error?) -> Void)? = nil) {
    let docRef: DocumentReference = db.collection(collectionName).document(documentName)
    loadHotReload(documentRef: docRef, snapshot: snapshot, completion: completion)
  }

  func loadHotReload(dirName: String, jsonFileName: String, snapshot: Bool = true, completion: ((Error?) -> Void)? = nil) {
    loadHotReload(collectionName: dirName, documentName: jsonFileName, snapshot: snapshot, completion: completion)
  }

  func hotReloadView(id: String) -> UIView? {
    if let stackView = self as? UIStackView {
      if stackView.arrangedSubviews.isEmpty { return nil }
      if let view = stackView.arrangedSubviews.first(where: { $0.accessibilityIdentifier == id } ) {
        return view
      }
      for subview in stackView.arrangedSubviews {
        if let view = subview.hotReloadView(id: id) {
          return view
        }
      }
    } else {
      if self.subviews.isEmpty { return nil }
      if let view = self.subviews.first(where: { $0.accessibilityIdentifier == id } ) {
        return view
      }
      for subview in self.subviews {
        if let view = subview.hotReloadView(id: id) {
          return view
        }
      }
    }
    return nil
  }
}
