#
# Be sure to run `pod lib lint ZJPhotoPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZJPhotoPod"
  s.version          = "0.2.1"
  s.summary          = "拍照／相册选取图片"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
拍照，允许编辑裁剪，选择相册时可以多选，默认是单选.
                        DESC

  s.homepage         = "https://github.com/zhujin001032/ZJPhotoPod"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zhujin001032" => "zhujin001xb@163.con" }
  s.source           = { :git => "https://github.com/zhujin001032/ZJPhotoPod.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {'ZJPhotoPod' => ['Pod/Assets/*.{png,xib,lproj}']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
