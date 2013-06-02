Pod::Spec.new do |s|
  s.name         = "RGKit"
  s.version      = "0.0.1"
  s.summary      = "Miscellaneous helpers."
  s.homepage     = "https://github.com/rhgills/rgkit-stable"
  s.license      = 'MIT'
  s.author       = { "Robert Gilliam" => "robert@robertgilliam.org" }
  s.source       = { :git => "https://github.com/rhgills/rgkit-stable.git", :tag => 'v0.0.1' }
  s.platform = :ios, '5.0'

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.requires_arc = true

  s.dependency 'OCHamcrest', '~> 2.0.0'
  s.dependency 'LRMocky', '~> 0.9.1x'
end
