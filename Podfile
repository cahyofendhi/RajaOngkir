# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RajaOngkir' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RajaOngkir
  pod 'Alamofire', '~> 4.7'
  pod 'RealmSwift'
  
  def testing_pods
      pod 'Quick'
      pod 'Nimble'
      pod 'Mockingjay'
  end
  
  target 'RajaOngkirTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
    
  end

  target 'RajaOngkirUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

    post_install do |installer|
        installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
            configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
        end
    end

end
