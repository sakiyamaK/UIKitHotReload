# UIKitHotReload

[![CI Status](https://img.shields.io/travis/sakiyama.k@gmail.com/UIKitHotReload.svg?style=flat)](https://travis-ci.org/sakiyama.k@gmail.com/UIKitHotReload)
[![Version](https://img.shields.io/cocoapods/v/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![License](https://img.shields.io/cocoapods/l/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![Platform](https://img.shields.io/cocoapods/p/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)


## Contents
- [Document](Documentation/index.md)
- [Installation](#Installation)
- [HotReload](#HotReload)
- [Usage](#Usage)

UIKitHotReloadはjsonファイルでiOSアプリのレイアウトを組むライブラリです。

ホットリロード機能を備えており、ビルド後や実機転送後でもXcodeを使うことなくリアルタイムにレイアウトが反映されます。

Releaseビルドの場合は内部にBundleされたjsonファイルを読み込むため、ホットリロードは機能しません。

## Installation

### CocoaPods

UIKitHotReload is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'UIKitHotReload'
```

## HotReload

UIKitHotReloadは[firestore/cloud firestore](https://firebase.google.com/docs/firestore?hl=ja)のリアルタイムアップデートの機能を利用することでホットリロードを実現しています。

[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)などのアドオン機能を使ってjsonが更新される度にfirestoreにuploadするスクリプトを実行させます。

推奨する設定方法を記載します。

### Visual Studio Code

#### Installation vscode-runonsave

jsonを保存すると同時にスクリプトを実行するためのアドオンをインストールします。

推奨アドオンは[vscode-runonsave](https://github.com/emeraldwalk/vscode-runonsave)です


#### Setting 
`path/to/project/.vscode/settings.json`に以下の設定を追記します。

```sh
{
  "emeraldwalk.runonsave":{
    "commands": [
      {
        "match": ".json$",
        "cmd": "node upload_json.js ${file} <path/to/serviceAccountKey.json> <admin_database_url>"
      }
    ]
  }
}
```
`<path/to/serviceAccountKey.json>`はfirebaseのサービスアカウントページの`秘密鍵の生成`から生成したものです。

`<admin_database_url>`はfirebaseのサービスアカウントページに記載されたものです。


### Installation firebase-admin

firestoreにuploadするためにfirebase-adminをインストールします。

```sh
npm install firebase-admin --save
```

### Setting Javascript

プロジェクトのルートに`upload_json.js`というファイル名で[このスクリプト](https://gist.githubusercontent.com/sakiyamaK/972bac65e7f4b82364c97d418b563c06/raw/c1ccc4e0a96dd91691df0d193aff8bcf8ac5f24e/upload_json_to_firestore.js)を保存します。

## Usage

### Quick Start

#### ViewController

`MainViewController.swift`

```swift 
import UIKit
import UIKitHotReload

final class MainViewController: UIViewController {

  private var label: UILabel? { self.view.hotReloadView(id: "id_label") as? UILabel }
  private var button: UIButton? { self.view.hotReloadView(id: "id_button") as? UIButton }
  private var image: UIImageView? { self.view.hotReloadView(id: "id_image") as? UIImageView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "main") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
  }
```

#### Layout

`views/main.json`

```json
{
  "class": "view",
  "id": "main",
  "background_color": [
    1,
    1,
    1
  ],
  "is_safe_area": false,
  "subviews": [
    {
      "class": "stack",
      "is_safe_area": true,
      "distribution": "fill_e",
      "alignment": "fill",
      "is_scroll_enabled": false,
      "spacing": 10,
      "subviews": [
        {
          "class": "label",
          "id": "id_label",
          "text": "Label Text",
          "font": {
            "name": "Bradley Hand",
            "size": 30
          }
        },
        {
          "class": "button",
          "id": "id_button",
          "text": "Button Title"
        },
        {
          "class": "imageview",
          "id": "id_image",
          "image": {
            "name": "image_file_name"
          },
          "layout": {
            "size": {
              "width": {
                "v": 200
              },
              "height": {
                "v": 200
              }
            }
          }
        }
      ]
    }
  ]
}
```

## Author

Kei Sakiyama, sakiyama.k@gmail.com

## License

UIKitHotReload is available under the MIT license. See the LICENSE file for more info.
