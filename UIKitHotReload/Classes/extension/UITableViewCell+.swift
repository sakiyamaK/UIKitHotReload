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
  static func initTableViewCellHotReload<T: UITableViewCell>(type: T.Type, style: UITableViewCell.CellStyle, reuseIdentifier: String,
                                                             dirName: String, fileName: String, fileType: FileType = .json,
                                                             snapshot: Bool? = nil,
                                                             completion: ((Result<T, Error>) -> Void)? = nil) -> T {
    let cell = type.init(style: style, reuseIdentifier: reuseIdentifier)

    let completion: ((Result<Void, Error>) -> Void) = { result in
      switch result{
      case .failure(let error):
        completion?(.failure(error))
      case .success():
        completion?(.success(cell))
      }
    }

    switch fileType {
    case .json:
      cell.contentView.loadHotReload(dirName: dirName, jsonFileName: fileName, snapshot: snapshot, completion: completion)
    case .yml:
      cell.contentView.loadHotReload(dirName: dirName, ymlFileName: fileName, snapshot: snapshot, completion: completion)
    case .yaml:
    cell.contentView.loadHotReload(dirName: dirName, yamlFileName: fileName, snapshot: snapshot, completion: completion)
    }
    return cell
  }
}
