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

  func hotReloadConstraint(id: String) -> NSLayoutConstraint? {
    if let constraint = self.constraints.first(where: { $0.identifier == id }) { return constraint }
    let subviews = (self is UIStackView) ? (self as! UIStackView).arrangedSubviews : self.subviews
    return subviews.map{ $0.hotReloadConstraint(id: id) }.first{$0 != nil} ?? nil

  }
}

public extension UIView {

  private func loadHotReload(documentRef: DocumentReference, fileType: FileType, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    documentRef.addSnapshotListener { (docSnapshot, error) in
      if error != nil {
        completion?(.failure(UIKitHotReloadError.notGettingDocuments))
        return
      }

      guard
        let data = docSnapshot?.data() else {
        let error = UIKitHotReloadError.notFoundData
        completion?(.failure(error))
        return
      }

      do {
        let viewModel = try Firestore.Decoder().decode(RootViewModel.self, from: data)
        guard viewModel.view != nil else {
          let error = UIKitHotReloadError.notFoundRootView
          completion?(.failure(error))
          return
        }
        viewModel.setupRootView(superview: self, fileType: fileType, snapshot: true)
        completion?(.success(()))
      } catch(let error) {
        completion?(.failure(error))
      }
    }
  }

  private func load(dirName: String, fileName: String, fileType: FileType = .json, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileType.rawValue) else {
      let error = UIKitHotReloadError.notFoundFile
      completion?(.failure(error))
      return
    }
    do {
      let fileUrl = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
      let viewModel: RootViewModel
      switch fileType {
      case .json:
        viewModel = try HotReloadDecoder().jsonDecoder.decode(RootViewModel.self, from: data)
      default:
        viewModel = try HotReloadDecoder().ymlDecoder.decode(RootViewModel.self, from: data)
      }
      guard viewModel.view != nil else {
        let error = UIKitHotReloadError.notFoundRootView
        completion?(.failure(error))
        return
      }
      viewModel.setupRootView(superview: self, fileType: fileType, snapshot: false)
      completion?(.success(()))
    } catch(let error) {
      completion?(.failure(error))
    }
  }

  func loadHotReload(collectionName: String, documentName: String, fileType: FileType = .json, snapshot: Bool? = nil, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    #if DEBUG
    let snapshot = snapshot ?? true
    #else
    let snapshot = snapshot ?? false
    #endif
    if snapshot {
      let docRef: DocumentReference = db.collection(collectionName).document(documentName)
      loadHotReload(documentRef: docRef, fileType: fileType, completion: completion)
    } else {
      load(dirName: collectionName, fileName: documentName, fileType: fileType, completion: completion)
    }
  }

  func loadHotReload(dirName: String, jsonFileName: String, snapshot: Bool? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
    loadHotReload(collectionName: dirName, documentName: jsonFileName, snapshot: snapshot, completion: completion)
  }

  func loadHotReload(dirName: String, ymlFileName: String, snapshot: Bool? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
    loadHotReload(collectionName: dirName, documentName: ymlFileName, fileType: .yml, snapshot: snapshot, completion: completion)
  }

  func loadHotReload(dirName: String, yamlFileName: String, snapshot: Bool? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
    loadHotReload(collectionName: dirName, documentName: yamlFileName, fileType: .yaml, snapshot: snapshot, completion: completion)
  }

}
