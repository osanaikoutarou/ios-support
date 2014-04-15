Pod::Spec.new do |s|
  s.name         = "ios-support"
  s.version      = "1.0.0"
  s.summary      = "An utility library maintained by teamLab."
  s.homepage     = "http://gitorious.team-lab.local/ios-support/ios-support"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Smartphone App Developer Team" => "lab-smartphone-dev@team-lab.com" }
  s.platform     = :ios
  s.source       = { :git => "git://gitorious.team-lab.local/ios-support/ios-support.git", :tag => "1.0.0" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.public_header_files = 'Classes/**/*.h'
  # s.framework  = ''
  s.requires_arc = true
  # s.dependency ''
end
