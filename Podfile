# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'diary' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for diary
  
  # UI
  pod 'SnapKit'
  pod 'RxFlow'
  pod 'FSCalendar'
  pod 'SideMenu'
  pod 'UITextView+Placeholder'
  pod 'FloatingPanel'
  pod 'ActiveLabel'
  pod 'Atributika'
  pod 'RxUIAlert'
  pod 'SwiftMessages'
  
  # Architecture
  pod 'ReactorKit'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxViewController'
  pod 'RxKeyboard'
  pod 'RxAnimated'
  pod 'RxTheme'
  pod 'RxGesture'
  pod 'RxLocalAuthentication'
  
  # Network
  pod 'Moya/RxSwift'
  
  # Security
  pod 'KeychainAccess'

  # DB
  #pod 'RxRealm'

  # ETC
  pod 'R.swift'
  pod 'Then'
  pod 'Carte'
  pod 'CGFloatLiteral'
  pod 'ReusableKit/RxSwift'

  target 'diaryTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'diaryUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  pods_dir = File.dirname(installer.pods_project.path)
  at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
end
