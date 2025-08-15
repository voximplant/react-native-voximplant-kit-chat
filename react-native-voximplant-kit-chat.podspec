require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
fabric_enabled = ENV['RCT_NEW_ARCH_ENABLED'] == '1'

Pod::Spec.new do |s|
  s.name         = "react-native-voximplant-kit-chat"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source_files = 'ios/*'
  s.source       = { :git => "https://github.com/voximplant.git", :tag => "#{s.version}" }

  s.dependency     'VoximplantKitChatUI', '1.3.0'

  if fabric_enabled
    install_modules_dependencies(s)
  else
    s.dependency 'React'
  end
end
