Pod::Spec.new do |spec|
  spec.swift_version = '5.0'
  spec.name = 'Cely'
  spec.version = '2.1.3'
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.summary = 'Cely’s goal is to add a login system into your app in under 30 seconds!'
  spec.homepage = 'https://github.com/cely-tools/Cely'
  spec.social_media_url = 'https://twitter.com/initfabian'
  spec.authors = { "Fabian Buentello" => "fabian.buentello@gmail.com" }
  spec.source = { :git => "https://github.com/cely-tools/Cely.git", :tag => spec.version.to_s }
  spec.platforms     = { :ios => "10.3" }
  spec.requires_arc = true

  spec.default_subspec = "Core"
  spec.subspec "Core" do |subspec|
    subspec.resources = 'Sources/Supporting Files/*.{storyboard,xib,xcassets,json,imageset,png}'
    subspec.source_files  = "Sources/*.swift"
    subspec.framework  = "Foundation"
  end

end
