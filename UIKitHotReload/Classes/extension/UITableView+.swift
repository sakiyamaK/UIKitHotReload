//
//  UITableView+.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/23.
//

import UIKit

public extension UITableView {
  func dequeueOrRegisterCellHotReload<T: UITableViewCell>(type: T.Type, style: UITableViewCell.CellStyle, reuseIdentifier: String,
                                                          dirName: String, fileName: String, fileType: FileType = .json,
                                                          snapshot: Bool? = nil,
                                                          completion:((Result<(T, Bool), Error>) -> Void)? = nil) -> T {
    if let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
      completion?(.success((cell, false)))
      return cell
    } else {
      let cell = UITableViewCell.initTableViewCellHotReload(type: type, style: style, reuseIdentifier: reuseIdentifier,
                                                            dirName: dirName, fileName: fileName, fileType: fileType,
                                                            snapshot: snapshot) { result in
        switch result {
        case .failure(let error):
          completion?(.failure(error))
        case .success(let cell):
          #if DEBUG
          let snapshot = snapshot ?? true
          #else
          let snapshot = snapshot ?? false
          #endif
          completion?(.success((cell, snapshot)))
        }
      }
      return cell
    }
  }
}
