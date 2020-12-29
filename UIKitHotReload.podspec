#
# Be sure to run `pod lib lint UIKitHotReload.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'UIKitHotReload'
  s.version          = '0.1.17'
  s.summary          = <<-DESC
  This is summary
  DESC

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC

  s.homepage         = 'https://github.com/sakiyamaK/UIKitHotReload'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kei Sakiyama' => 'sakiyama.k@gmail.com' }
  s.source           = { :git => 'https://github.com/sakiyamaK/UIKitHotReload.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'UIKitHotReload/Classes/**/*'

  s.swift_versions = '5.3'

  s.static_framework = true

  s.prepare_command = <<-PREPARE_COMMAND_END
    cp -f UIKitHotReload/Classes/script/upload_admin.js ./upload_admin.js
    cp -f UIKitHotReload/Classes/script/package.json ./package.json
    cp -f UIKitHotReload/Classes/script/package-lock.json ./package-lock.json
    npm install
  PREPARE_COMMAND_END

  # s.resource_bundles = {
  #   'HotreloadUIKit' => ['HotreloadUIKit/Assets/*.png']
  # } 

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Firebase/Firestore'
  s.dependency 'FirebaseFirestoreSwift'
  s.dependency 'Kingfisher'
  s.dependency 'Yams'
end
