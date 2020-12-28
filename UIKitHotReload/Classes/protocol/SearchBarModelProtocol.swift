//
//  SearchBarModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

public protocol SearchBarModelProtocol: ViewModelProtocol, TextModelProtocol, TextInputTraitsModelProtocol {
  func setupSearchBar(_ searchBar: UISearchBar)
}

public extension SearchBarModelProtocol {

  func setupSearchBar(_ searchBar: UISearchBar) {
    searchBar.text = text
    searchBar.textContentType = textContentType
    searchBar.autocapitalizationType = capitalizationType
    searchBar.keyboardType = keyboardType
    searchBar.returnKeyType = returnKeyType
    searchBar.isSecureTextEntry = isSecureTextEntry
    searchBar.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
  }
}
