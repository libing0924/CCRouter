#
# Be sure to run `pod lib lint CCRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CCRouter'
  s.version          = '1.0.0'
  s.summary          = 'CCRouter is a decoupling framework for controller jumps. It is highly scalable and suitable for multiple business scenarios.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/libing0924/CCRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.platform     = :ios, '8.0'
  s.author           = { 'libing0924' => 'libingcc0924@gmail.com' }
  s.source           = { :git => 'https://github.com/libing0924/CCRouter.git', :tag => "#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LBModuleServer/LBModuleServer/URLModule/*.{h,m}'
  
  # s.resource_bundles = {
  #   'CCRouter' => ['/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
