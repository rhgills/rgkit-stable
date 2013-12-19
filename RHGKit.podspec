Pod::Spec.new do |s|
  s.name         = "RHGKit"
  s.version      = "0.1.8"
  s.summary      = "Miscellaneous helpers."
  s.homepage     = "https://github.com/rhgills/rhgkit"
  s.license      = 'MIT'
  s.author       = { "Robert Gilliam" => "robert@robertgilliam.org" }
  s.source       = { :git => "https://github.com/rhgills/rhgkit.git", :tag => s.version.to_s }
  s.platform = :ios, '5.0'

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.requires_arc = true

  s.dependency 'CocoaLumberjack', '~> 1.6.0'
end
