Pod::Spec.new do |s|
 s.name = 'Cely'
 s.version = '1.1.0'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'Cely’s goal is to add a login system into your app in under 30 seconds!'
 s.homepage = 'http://rahulkatariya.me'
 s.social_media_url = 'https://twitter.com/initfabian'
 s.authors = { "Fabian Buentello" => "fabian.buentello@gmail.com" }
 s.source = { :git => "https://github.com/ChaiOne/Cely.git", :tag => "v"+s.version.to_s }
 s.platforms     = { :ios => "9.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.resources = 'Sources/Supporting Files/*.{storyboard,xib,xcassets,json,imageset,png}'
     ss.source_files  = "Sources/*.swift"
     ss.framework  = "Foundation"
 end

end
