# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AirPorts' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for AirPorts
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod 'RealmSwift', '~> 3.0.2'
  pod 'Alamofire', '~> 4.5'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'Moya'


  target 'AirPortsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'Moya'
    pod 'RealmSwift'

  end

  target 'AirPortsUITests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Nimble'
    pod 'KIF'
    pod 'RealmSwift'
  end

end
