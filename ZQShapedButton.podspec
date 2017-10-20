Pod::Spec.new do |s|
  s.name         = "ZQShapedButton"
  s.version      = "0.1"
  s.source       = { :git => "https://github.com/zhaozzq/ZQShapedButton.git", :tag => "#{s.version}" }
  s.summary      = "A shaped button in Swift."
  s.description  = "A shaped button in Swift."
  s.homepage     = "https://github.com/zhaozzq/ZQShapedButton"
  s.license      = 'MIT'
  s.authors      = {'zhaozzq' => 'zhao_zzq2012@163.com'}
  s.social_media_url   = "https://twitter.com/ZHAOZQMOS"
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.9"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  s.source_files  = "ZQShapedButton/Sources/**/*.swift"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0'}
end