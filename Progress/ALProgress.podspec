#
#  Be sure to run `pod spec lint Progress.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "ALProgress"

  s.version      = "1.0"

  s.summary      = "iOS Progress 小组件"

  s.description  = "iOS 组件-Progress"

  s.homepage     = "https://github.com/295060456/Progress"

  s.license      = "MIT"

  s.author       = { "alan" => "alan969543491@gmail.com" }

  s.source       = { :git => "https://github.com/295060456/Progress.git", :tag => "#{s.version}" }

  s.source_files = "Progress/Progress/**/*.{h,m}"

  s.requires_arc = true

  s.ios.deployment_target = "10.0"

end
