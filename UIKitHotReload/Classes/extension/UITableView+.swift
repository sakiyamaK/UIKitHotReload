//
//  UITableView+.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/23.
//

import UIKit

public extension UITableView {
  func dequeueOrRegisterCellHotReload<T: UITableViewCell>(type: T.Type, style: UITableViewCell.CellStyle, dirName: String, jsonFileName: String, reuseIdentifier: String, completion:((Result<(T, Bool), Error>) -> Void)? = nil) -> T {
    if let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
      completion?(.success((cell, false)))
      return cell
    } else {
      let cell = UITableViewCell.initTableViewCellHotReload(type: type, style: style, dirName: dirName, jsonFileName: jsonFileName, reuseIdentifier: reuseIdentifier) { result in
        switch result {
        case .failure(let error):
          completion?(.failure(error))
        case .success(let cell):
          completion?(.success((cell, true)))
        }
      }
      return cell
    }
  }
}
