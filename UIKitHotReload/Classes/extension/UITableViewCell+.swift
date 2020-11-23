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

extension UITableViewCell {
  static func initTableViewCellHotReload<T: UITableViewCell>(type: T.Type, style: UITableViewCell.CellStyle,
                            dirName: String, jsonFileName: String, reuseIdentifier: String,
                            snapshot: Bool? = nil,
                            completion: ((Result<T, Error>) -> Void)? = nil) -> T {
    let cell = type.init(style: style, reuseIdentifier: reuseIdentifier)
    cell.contentView.loadHotReload(dirName: dirName, jsonFileName: jsonFileName, snapshot: snapshot) {result in
      switch result{
      case .failure(let error):
        completion?(.failure(error))
      case .success():
        completion?(.success(cell))
      }
    }
    return cell
  }
}
