//
//  UITableViewCell+.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

private let db = Firestore.firestore()

public extension UITableViewCell {
  convenience init(style: UITableViewCell.CellStyle,
                   dirName: String, jsonFileName: String, reuseIdentifier: String,
                   completion: ((Result<Void, Error>) -> Void)? = nil) {
    self.init(style: style, reuseIdentifier: reuseIdentifier)
    self.loadTableViewCellHotReload(dirName: "views", jsonFileName: "table", reuseIdentifier: reuseIdentifier, completion: completion)
  }
}

public extension UITableViewCell {
  private func loadTableViewCellHotReload(documentRef: DocumentReference, reuseIdentifier: String, completion: (((Result<Void, Error>)) -> Void)? = nil) {

    documentRef.addSnapshotListener { (docSnapshot, error) in
      if let _error = error {
        print("Error getting documents: \(_error)")
        completion?(.failure(_error))
        return
      }

      guard
        let data = docSnapshot?.data() else {
        let error = NSError.init(domain: "no cell data", code: 130, userInfo: nil)
        completion?(.failure(error))
        return
      }

      do {
        let rootViewModel = try Firestore.Decoder().decode(RootViewModel.self, from: data)
        guard
          let viewModel = rootViewModel.cells?.first(where: { (cell) -> Bool in
            cell.reuseIdentifier  == reuseIdentifier
          }),
          let view = viewModel.view
        else {
          let error = NSError.init(domain: "no cell view", code: 140, userInfo: nil)
          completion?(.failure(error))
          return
        }
        self.subviews.filter { $0.accessibilityIdentifier == view.accessibilityIdentifier }.first?.removeFromSuperview()
        self.contentView.addSubview(view)
        if let _centerX = viewModel.layout.center?.x {
          view.centerXEqualToSuperView(isSafeArea: viewModel.isSafeArea, constant: _centerX.value, priority: _centerX.priority)
        }
        if let _centerY = viewModel.layout.center?.y {
          view.centerYEqualToSuperView(isSafeArea: viewModel.isSafeArea, constant: _centerY.value, priority: _centerY.priority)
        }
        if let _position = viewModel.layout.position {
          view.positionSetToSuperView(isSafeArea: viewModel.isSafeArea, position: _position)
        }
        if let _margin = viewModel.layout.margin {
          view.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea, margin: _margin)
        }
        if !viewModel.layout.isSetEdge {
          view.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea)
        }
        if let color = viewModel.selectedBackgroundColor {
          let bgView = UIView()
          bgView.backgroundColor = color
          self.selectedBackgroundView = bgView
        }
        self.contentView.backgroundColor = viewModel.backgroundColor
        viewModel.setupView(view, backgroundColorClear: true)
        completion?(.success(()))
      } catch(let error) {
        completion?(.failure(error))
      }
    }
  }

  func loadTableViewCellHotReload(collectionName: String, documentName: String, reuseIdentifier: String, snapshot: Bool? = nil, completion: (((Result<Void, Error>)) -> Void)? = nil) {
    #if DEBUG
    let snapshot = snapshot ?? true
    #else
    let snapshot = snapshot ?? false
    #endif
    if snapshot {
      let docRef: DocumentReference = db.collection(collectionName).document(documentName)
      loadTableViewCellHotReload(documentRef: docRef, reuseIdentifier: reuseIdentifier, completion: completion)
    } else {
      //      load(dirName: collectionName, jsonFileName: documentName, completion: completion)
    }
  }

  func loadTableViewCellHotReload(dirName: String, jsonFileName: String, reuseIdentifier: String, snapshot: Bool? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
    loadTableViewCellHotReload(collectionName: dirName, documentName: jsonFileName, reuseIdentifier: reuseIdentifier, snapshot: snapshot, completion: completion)
  }
}
