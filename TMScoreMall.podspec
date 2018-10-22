#
#  Be sure to run `pod spec lint TMScoreMall.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
 # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TMScoreMall"
  s.version      = "0.0.7"
  s.summary      = "This is a summary"
  s.homepage     = "https://github.com/lizishiye/TMScoreMall.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "lizishiye" => "1063357883@qq.com" }
  s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/lizishiye/TMScoreMall.git", :tag => "#{s.version}" }
  s.source_files  = "TMScoreMall/**/*.{h}"

  s.requires_arc = true 

  s.resource  = "TMScoreMall/Resource/TMPointMallImages.bundle"
  s.vendored_frameworks = 'TMScoreMall/Frameworks/TMScoreMall.framework'

  # s.xcconfig = {
  #   'VALID_ARCHS' => 'arm64 x86_64'
  # }

  valid_archs = ['armv7s','arm64','x86_64']
s.xcconfig = {
  'VALID_ARCHS' =>  valid_archs.join(' '),
}
s.pod_target_xcconfig = {
    'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)'
}


  s.dependency'TMSDK'
  s.dependency'AFNetworking'
  s.dependency'SDWebImage'
  s.dependency'Masonry'
  s.dependency'MJRefresh'
  s.dependency'SVProgressHUD'
  s.dependency'SGPagingView'
  s.dependency'MJExtension'
end
