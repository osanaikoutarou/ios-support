Pod::Spec.new do |s|
  s.name         = "ios-support"
  s.version      = "1.0.2.3"
  s.summary      = "An utility library maintained by teamLab."
  s.homepage     = "https://github.com/team-lab/ios-support"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Smartphone App Developer Team" => "lab-smartphone-dev@team-lab.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/team-lab/ios-support.git", :tag => "1.0.2.3" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.public_header_files = 'Classes/**/*.{h}'
  s.resources    = 'Classes/**/*.xib'
  # s.framework  = ''
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 2.2'
  s.ios.deployment_target = '6.0'
end
