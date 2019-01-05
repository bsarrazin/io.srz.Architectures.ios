source 'git@github.com:CocoaPods/Specs.git'

inhibit_all_warnings!
platform :ios, '12.1'
workspace 'Architectures'

target 'MVVM' do
  project 'MVVM/MVVM.xcodeproj'
  use_frameworks!

  pod 'RxCocoa'
  pod 'RxSwift'

  target 'MVVMTests' do
    inherit! :search_paths
  end

end
