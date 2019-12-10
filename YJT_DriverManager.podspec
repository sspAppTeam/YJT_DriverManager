#
# Be sure to run `pod lib lint YJT_DriverManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJT_DriverManager'
  s.version          = '0.1.1'
  s.summary          = '驾驶员信息'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
业务组件化-驾驶员业务
                       DESC

  s.homepage         = 'https://github.com/sspAppTeam/YJT_DriverManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SSPSource' => '2316585240@qq.com' }
  s.source           = { :git => 'https://github.com/sspAppTeam/YJT_DriverManager.git', :tag => s.version.to_s }
#  https://github.com/sspAppTeam/SSSpecs.git
  s.source           = { :git => 'https://github.com/sspAppTeam/SSSpecs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YJT_DriverManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YJT_DriverManager' => ['YJT_DriverManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
#
   s.dependency 'Masonry'
   s.dependency 'SSNetworkOC'
#   ,:git => 'https://github.com/sspAppTeam/SSNetworkOC.git'
end
