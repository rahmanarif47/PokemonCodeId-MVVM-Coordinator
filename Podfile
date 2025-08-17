# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'PokepoCodeId' do
  use_frameworks!

  # Pods for PokepoCodeId
  pod 'Alamofire', '~> 5.9'
  pod 'RxSwift', '~> 6.6'
  pod 'RxCocoa', '~> 6.6'
  pod 'MBProgressHUD', '~> 1.2'
  pod 'XLPagerTabStrip', '~> 9.0'
  pod 'RealmSwift', '~> 10.52'
  pod 'Kingfisher', '~> 7.12'
  pod 'Wormholy'

  target 'PokepoCodeIdTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PokepoCodeIdUITests' do
    # Pods for testing
  end
end

# 👉 post_install harus di luar semua target
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      flags = config.build_settings['OTHER_LDFLAGS']
      if flags.is_a?(Array)
        # Buang semua yang nyebut libarclite / objc-arc
        config.build_settings['OTHER_LDFLAGS'] = flags.reject { |f|
          f.include?("libarclite") || f.include?("objc-arc")
        }
      end
    end
  end
end
