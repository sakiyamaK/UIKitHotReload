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
  func hotReloadView(id: String) -> UIView? {
    if self.accessibilityIdentifier == id { return self }
    let subviews = (self is UIStackView) ? (self as! UIStackView).arrangedSubviews : self.subviews
    return subviews.map{ $0.hotReloadView(id: id) }.first{$0 != nil} ?? nil
  }
}

public extension UIView {

  private func loadHotReload(documentRef: DocumentReference, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    documentRef.addSnapshotListener { (docSnapshot, error) in
      if let _error = error {
        print("Error getting documents: \(_error)")
        completion?(.failure(_error))
        return
      }

      guard
        let data = docSnapshot?.data() else {
        let error = NSError.init(domain: "no data", code: 100, userInfo: nil)
        completion?(.failure(error))
        return
      }

      do {
        let viewModel = try Firestore.Decoder().decode(RootViewModel.self, from: data)
        guard viewModel.view != nil else {
          let error = NSError.init(domain: "no rootView", code: 110, userInfo: nil)
          completion?(.failure(error))
          return
        }
        viewModel.setupRootView(superview: self, snapshot: true)
        completion?(.success(()))
      } catch(let error) {
        completion?(.failure(error))
      }
    }
  }

  private func load(dirName: String, jsonFileName: String, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    guard let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") else {
      let error = NSError.init(domain: "no file", code: 120, userInfo: nil)
      completion?(.failure(error))
      return
    }
    do {
      let fileUrl = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
      let viewModel = try JSONDecoder().decode(RootViewModel.self, from: data)
      guard viewModel.view != nil else {
        let error = NSError.init(domain: "no view", code: 110, userInfo: nil)
        completion?(.failure(error))
        return
      }
      viewModel.setupRootView(superview: self, snapshot: false)
      completion?(.success(()))
    } catch(let error) {
      completion?(.failure(error))
    }
  }

  func loadHotReload(collectionName: String, documentName: String, snapshot: Bool? = nil, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    #if DEBUG
    let snapshot = snapshot ?? true
    #else
    let snapshot = snapshot ?? false
    #endif
    if snapshot {
      let docRef: DocumentReference = db.collection(collectionName).document(documentName)
      loadHotReload(documentRef: docRef, completion: completion)
    } else {
      load(dirName: collectionName, jsonFileName: documentName, completion: completion)
    }
  }

  func loadHotReload(dirName: String, jsonFileName: String, snapshot: Bool? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
    loadHotReload(collectionName: dirName, documentName: jsonFileName, snapshot: snapshot, completion: completion)
  }
}
