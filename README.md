# UIKitHotReload

[![CI Status](https://img.shields.io/travis/sakiyama.k@gmail.com/UIKitHotReload.svg?style=flat)](https://travis-ci.org/sakiyama.k@gmail.com/UIKitHotReload)
[![Version](https://img.shields.io/cocoapods/v/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![License](https://img.shields.io/cocoapods/l/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)
[![Platform](https://img.shields.io/cocoapods/p/UIKitHotReload.svg?style=flat)](https://cocoapods.org/pods/UIKitHotReload)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

UIKitHotReload is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UIKitHotReload'
```

## setting realtime update

### vscode

#### run on save
```
https://github.com/emeraldwalk/vscode-runonsave
```

#### setting 
`path/to/project/.vscode/settings.json`に記載

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
`<path/to/serviceAccountKey.json>`とfirebaseのサービスアカウントページの`秘密鍵の生成`から生成したもの
`<admin_database_url>`はfirebaseのサービスアカウントページに記載されたもの


### firebase-admin

```sh
npm install firebase-admin --save
```

### javascript script

set project root [this script](https://gist.githubusercontent.com/sakiyamaK/972bac65e7f4b82364c97d418b563c06/raw/c1ccc4e0a96dd91691df0d193aff8bcf8ac5f24e/upload_json_to_firestore.js)

## Author

Kei Sakiyama, sakiyama.k@gmail.com

## License

UIKitHotReload is available under the MIT license. See the LICENSE file for more info.
