#Cely 

Plug-n-Play iOS login framework written in Swift.


## Overview
Cely's goal is to add a login system into your up in under 20 seconds! 

There are many "How to build a login system for iOS" tutorials that tell you to [store credentials in NSUserDefaults](http://im2.ezgif.com/tmp/ezgif-1182228405.gif), which is incorrect. The need to be stored in  

1. What Cely takes care of for you.
2. Requirements
3. Integration
4. Usage
  - Login Redirect
  - User Model

## What Cely takes care of for you
<#Description of what you have to do if youre not using Cely>

## Requirements
- iOS 8.0+
- Xcode 7

## Integration (WIP!!!!)

<#Steps on how to integrate Cely into your project>


####CocoaPods (iOS 8+, OS X 10.9+)
You can use [Cocoapods](http://cocoapods.org/) to install `Cely`by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'Cely'
end
```
Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:


####Carthage (iOS 8+, OS X 10.9+)
You can use [Carthage](https://github.com/Carthage/Carthage) to install `Cely` by adding it to your `Cartfile`:

```
bitbucket "fbuentello/Cely"
```

####Swift Package Manager
You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Cely` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .Package(url: "<URL>", versions: "0.0.1" ..< Version.max)
    ]
)
```

Note that the [Swift Package Manager](https://swift.org/package-manager) is still in early design and development, for more infomation checkout its [GitHub Page](https://github.com/apple/swift-package-manager)

####Manually (iOS 7+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag Cely.swift to the project tree
2. for Workspaces, include the whole Cely.xcodeproj
3. 

## Usage

####Login Redirect

Cely's **Simple Setup** function will get you up and running in a matter of seconds. Inside of your `AppDelegate.swift` simply `import Cely`:

```Swift
// AppDelegate.swift

import Cely

```
and call the `setup(_:)` function inside of your `didFinishLaunchingWithOptions` method.

```Swift
// AppDelegate.swift

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	
	Cely.setup(with: window)
	
	...
}
```
####User Model

Inside of your User model, simply conform to the `CelyUser` protocol and add all the properties you want Cely to save.

```Swift
class User: CelyUser {

    enum Properties: CelyProperties {
        case Username = "username"
        case Email = "email"
        case Token = "token"
    }
    
    ...   
}
```

#####Example User model

```

import Cely

struct User: CelyUser {

    private init() {}
    static let ref = User()

    enum Property: CelyProperties {
        case Username = "username"
        case Email = "email"
        case Token = "token"

        func save(value: AnyObject) {
            Cely.save(self.rawValue, value: value)
        }

        func get() -> AnyObject? {
            return Cely.get(self.rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(value: AnyObject, as property: Property) {
        property.save(value)
    }

    static func save(data: [Property : AnyObject]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(property: Property) -> AnyObject? {
        return property.get()
    }
}

```