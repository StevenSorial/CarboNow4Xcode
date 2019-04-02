deploymentTarget = '10.12'

platform :osx, deploymentTarget
use_frameworks!

target 'carbon-now-sh for Xcode' do
    pod 'SwiftLint'
    target 'carbon-now-sh' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        if config.name.include?("Release")
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Osize'
        end
        if config.name.include?("Debug")
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      end
    end
  end
  