#
#  Be sure to run `pod spec lint TMScoreMall.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TMScoreMall"
  s.version      = "0.0.1"
  s.summary      = "The TMScoreMall project."
  s.homepage     = "https://github.com/lizishiye/TMScoreMall.git"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "lizishiye" => "1063357883@qq.com" }
  s.source = { :git => "https://github.com/lizishiye/TMScoreMall.git", :tag => "0.0.1"}
  s.source_files  = "TMScoreMall/**/*"
  s.description      = <<-DESC
                       It is a marquee view used on iOS, which implement by Objective-C.
                       DESC

  s.ios.deployment_target = "9.0"
  s.requires_arc = true 

  s.dependency 'TMSDK', '~> 0.0.2-beta.3'
  # s.dependency 'AFNetworking'
  # s.dependency 'SDWebImage'
  # s.dependency 'Masonry'
  # s.dependency 'MJRefresh'
  # s.dependency 'SVProgressHUD'
  # s.dependency 'SGPagingView'
  # s.dependency 'MJExtension'
  # s.dependency 'UMengAnalytics-NO-IDFA'

end
