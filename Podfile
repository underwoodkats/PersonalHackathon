 platform :ios, '12.0'

target 'Encore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Encore
  pod 'TipSee'
  pod 'IQKeyboardManager'
  pod 'Flurry-iOS-SDK/FlurrySDK' #Analytics Pod

end

# This snippet could be removed when Pods vendors will support Apple M1
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
