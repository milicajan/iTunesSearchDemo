# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'

# platform :ios, '10.2'
use_frameworks!

def default_pods
    pod 'SnapKit'
    pod 'Alamofire'
    pod 'Kingfisher'
    pod 'MBProgressHUD'
end

target 'iTunesDemo' do
  default_pods
end

post_install do |installer|
    puts("Update debug pod settings to speed up build time")
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
end
