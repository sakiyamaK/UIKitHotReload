# UIKitHotReload

[![CI Status](https://img.shields.io/travis/sakiyama.k@gmail.com/UIKitHotReload.svg?style=flat)](https://travis-ci.org/sakiyama.k@gmail.com/UIKitHotReload)
[![Version](https://img.shields.io/cocoapods/v/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![License](https://img.shields.io/cocoapods/l/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![Platform](https://img.shields.io/cocoapods/p/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)


## Contents
- [Document](#documentation)
- [Installation](#installation)
- [HotReload](#hotReload)
- [Usage](#usage)

UIKitHotReloadはjson/ymlファイルでiOSアプリのレイアウトを組むライブラリです。

ホットリロード機能を備えており、ビルド後や実機転送後でもXcodeを使うことなくリアルタイムにレイアウトが反映されます。

Releaseビルドの場合は内部にBundleされたjson/ymlファイルを読み込むため、ホットリロードは機能しません。

<img src="https://i.gyazo.com/c660f221b1897c56ae1abbfed558da9f.gif" />

## Documentation

[詳しくはこちら](https://github.com/sakiyamaK/UIKitHotReload/blob/main/Documentation/index.md)

## HotReload

UIKitHotReloadは[firebase/cloud firestore](https://firebase.google.com/docs/firestore?hl=ja)のリアルタイムアップデートの機能を利用することでホットリロードを実現しています。

[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)などのアドオン機能を使ってjsonが更新される度にfirestoreにuploadするスクリプトを実行させます。

推奨する設定方法を記載します。

### firestore
[firestore](https://firebase.google.com/docs/firestore?hl=ja)の設定をします。

### Xcode

1. nodeをインストールします。(すでにインストール済みの場合は不要です)
2. Xcodeファイルリストからプロジェクトを選択し、TARGETSの中から対象のアプリを選択します。Build Phasesタブを選択し、左上の小さい+ボタンを押し、`New Run Script Phases`を選択します。
3. `new Run Script phase`を`Compile Sources phase`より上で`Check Pods Manifest.lock`より下にドラッグします。`new Run Script phase`を開き、以下のscriptをペーストします。

```
cp -f $PODS_ROOT/UIKitHotReload/UIKitHotReload/Classes/script/upload_admin.js ./upload_admin.js
cp -f $PODS_ROOT/UIKitHotReload/UIKitHotReload/Classes/script/package.json ./package.json
cp -f $PODS_ROOT/UIKitHotReload/UIKitHotReload/Classes/script/package-lock.json ./package-lock.json
npm install
```

4. プロジェクトをビルドし、$SRCROOTのフォルダの中に`package.json`, `package-lock.json` , `upload_admin.js`があることを確認します。

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
        "cmd": "node ./upload_admin.js ${file} <path/to/serviceAccountKey.json>"
      },
      {
        "match": ".yml$",
        "cmd": "node ./upload_admin.js ${file} <path/to/serviceAccountKey.json>"
      },
      {
        "match": ".yaml$",
        "cmd": "node ./upload_admin.js ${file} <path/to/serviceAccountKey.json>"
      }
    ]
  }
}
```
`<path/to/serviceAccountKey.json>`はfirebaseのサービスアカウントページの`秘密鍵の生成`から生成したものです。

詳しくは[firebaseの公式ドキュメント](https://firebase.google.com/docs/admin/setup?hl=ja#initialize-sdk
)を確認してください。

### Usage

#### Quick Start

##### ViewController

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

##### Layout

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
