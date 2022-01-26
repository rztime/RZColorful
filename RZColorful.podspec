#
# Be sure to run `pod lib lint RZColorful.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RZColorful'
  s.version          = '1.4.0'
  s.summary          = 'NSAttributedString富文本的快捷设置方法集合,以及UITextView、UITextField、UILabel富文本简单优雅的使用, UILabel支持富文本点击，超行折叠、展开功能'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
NSAttributedString 富文本方法 以及与html互相转换, UILabel的富文本点击事件
                       DESC

  s.homepage         = 'https://github.com/rztime/RZColorful'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rztime' => 'rztime@vip.qq.com' }
  s.source           = { :git => 'https://github.com/rztime/RZColorful.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RZColorful/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RZColorful' => ['RZColorful/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
