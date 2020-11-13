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

## vscode
### install run on save
```
https://github.com/emeraldwalk/vscode-runonsave
```

### setting realtime update

`path/to/project/.vscode/setting.json`に記載

```
{
"emeraldwalk.runonsave":{
"commands": [
{
"match": ".json$",
"cmd": "node upload_json.js ${file}"
}
]
}
}
```

```sh
{
"emeraldwalk.runonsave":{
"commands": [
{
"match": ".json$",
"cmd": "node upload_json.js ${file}"
}
]
}
}
```
## Author

Kei Sakiyama, sakiyama.k@gmail.com

## License

UIKitHotReload is available under the MIT license. See the LICENSE file for more info.
