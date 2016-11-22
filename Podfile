# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'openxc-ios-framework' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for openxc-ios-framework
  pod 'ProtocolBuffers-Swift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end