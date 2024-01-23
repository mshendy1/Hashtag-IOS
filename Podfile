# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'HashTag' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for HashTag
  pod "CDAlertView", '0.11.0'
  pod 'SDWebImage', '5.14.2'
  pod 'IQKeyboardManager', '6.5.0'
  pod 'LanguageManager-iOS'
  pod 'netfox', '1.21.0'
  pod 'AEOTPTextField'
  pod "AlignedCollectionViewFlowLayout", '1.1.2'
  pod 'IndicateKit', '2.0.0'
  pod 'FBSDKLoginKit', '5.15.1'
  pod 'FacebookCore', '0.9.0'
  pod 'CHIPageControl/Jaloro'
  pod 'Alamofire', '5.6.4'
  pod 'iOSDropDown', '0.4.0'
  pod 'GoogleSignIn', '5.0.0'
  pod 'youtube-ios-player-helper'
  pod 'DropDown'
  pod "ImageSlideshow/SDWebImage"
  pod 'ImageSlideshow'
 # pod 'GooglePlaces', '4.0'
#  pod 'GoogleMaps'
  pod 'QCropper'
  pod 'VerticalCardSwiper'
  pod 'SwiftGen'
  pod 'NotificationBannerSwift', '~> 3.0.0'
# pod 'TwitterKit'

  pod 'ListPlaceholder'
  
  post_install do |installer|
      installer.generated_projects.each do |project|
        project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
          end
        end
      end
    end

  target 'HashTagTests' do
    inherit! :search_paths
    # Pods for testing
  end
  target 'HashTagUITests' do
    # Pods for testing
  end
end
