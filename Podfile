# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Ribeat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # Pods for SafeRT

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire',  '~> 4.5'
  pod 'SwiftSocket'
 	pod 'Embassy', '~> 4.0'
  pod 'EnvoyAmbassador', '~> 4.0'
 
  target 'RibeatTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
  end

end
