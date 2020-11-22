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
        guard let view = viewModel.view else {
          let error = NSError.init(domain: "no view", code: 110, userInfo: nil)
          completion?(.failure(error))
          return
        }

        self.subviews.filter { $0.accessibilityIdentifier == view.accessibilityIdentifier }.first?.removeFromSuperview()
        self.addSubview(view)
        view.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea)
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
      guard let view = viewModel.view else {
        let error = NSError.init(domain: "no view", code: 110, userInfo: nil)
        completion?(.failure(error))
        return
      }
      self.subviews.filter { $0.accessibilityIdentifier == view.accessibilityIdentifier }.first?.removeFromSuperview()
      self.addSubview(view)
      view.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea)
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
