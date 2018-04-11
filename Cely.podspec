Pod::Spec.new do |s|
 s.name = 'Cely'
 s.version = '2.0.3'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'Cely’s goal is to add a login system into your app in under 30 seconds!'
 s.homepage = 'https://chaione.com/'
 s.social_media_url = 'https://twitter.com/initfabian'
 s.authors = { "Fabian Buentello" => "fabian.buentello@gmail.com" }
 s.source = { :git => "https://github.com/ChaiOne/Cely.git", :tag => s.version.to_s }
 s.platforms     = { :ios => "9.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.resources = 'Sources/Supporting Files/*.{storyboard,xib,xcassets,json,imageset,png}'
     ss.source_files  = "Sources/*.swift"
     ss.framework  = "Foundation"
 end

end
