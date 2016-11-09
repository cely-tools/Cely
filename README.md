<div style="text-align:center"><img src ="Images/READMEHeader.png" /></div>

![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)
![bitrise status](https://www.bitrise.io/app/aff729145cb46dfe.svg?token=YUV0bymd7P_w2tdiKw2xOQ&branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/chaione/cely/branch/master/graph/badge.svg)](https://codecov.io/gh/chaione/cely)

> Prounounced Cell-Lee

## Overview
Cely's goal is to add a login system into your app in under 30 seconds! 

## Background
Whether you're building an app for a client or for a hackathon, building a login system, no matter how basic it is, can be very tedious and time-consuming. Cely's architecture has been battle tested on countless apps, and Cely guarantees you a fully functional login system in a fraction of the time. You can trust Cely is handling login credentials correctly as well since Cely is built on top of [Locksmith](https://github.com/matthewpalmer/Locksmith), swift's most popular Keychain wrapper. 



###Details:
What does Cely does for you? 

1. Simple API to store user creditials and information **securely**
 - `Cely.save("SUPER_SECRET_STRING", forKey: "token", securely: true)`
2. Manages switching between your app's Home Screen and Login Screen with:
 - `Cely.changeStatus(to: .loggedIn) // or .loggedOut`
3. Customizable starter Login screen(or you can use your login screen)
 
What Cely **does not do** for you? 

1. Network requests
2. Handle Network errors
3. Anything with the network 

## Requirements
- Xcode 8
- swift 3.0

## Installation

###Carthage
```
github "ChaiOne/Cely"
```
Cely will also include [`Locksmith`](https://github.com/matthewpalmer/Locksmith) when you import it into your project, so be sure to add `Locksmith` in your copy phase script.

> $(SRCROOT)/Carthage/Build/iOS/Cely.framework  
> $(SRCROOT)/Carthage/Build/iOS/Locksmith.framework

####Keychain entitlement Part(Xcode 8 bug?)
Be sure to [turn on Keychain entitlements](http://stackoverflow.com/a/31421742/1973339) for your app, not doing so will prevent Cely from saving data to the keychain. 

## Usage

###Setup(30 seconds)

#### User Model (`User.swift`)
Let's start by creating a `User` model that conforms to the [`CelyUser`](#Cely.CelyUser) Protocol:

```swift
// User.swift

import Cely

struct User: CelyUser {

	enum Property: CelyProperty {
		case token = "token"
	}
}

```
####Login redirect(`AppDelegate.swift`)

Cely's **Simple Setup** function will get you up and running in a matter of seconds. Inside of your `AppDelegate.swift` simply `import Cely` and call the [`setup(_:)`](#Cely.setup) function inside of your `didFinishLaunchingWithOptions` method.

```swift
// AppDelegate.swift

import Cely

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: Any]?) -> Bool {
	
	Cely.setup(with: window, forModel: User(), requiredProperties: [.token])
	
	...
}
```

<h3 style="text-align: center">Hit RUN!!</h3>

### CelyOptions
#### Handle Login Credentials
Now how do we get the `username` and `password` from Cely's default LoginViewController? It's easy, just pass in a completion block for the `.loginCompletionBlock`. Check out [`CelyOptions`](#Cely.CelyOptions) for more info.

```swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    Cely.setup(with: window!, forModel: User(), requiredProperties: [.token], withOptions: [
        .loginCompletionBlock: { (username: String, password: String) in
            if username == "asdf" && password == "asdf" {
                Cely.save(username, forKey: "username")
                Cely.save("FAKETOKEN:\(username)\(password)", forKey: "token", securely: true)
                Cely.changeStatus(to: .loggedIn)
            }
        }
    ])

    return true
}
```
#### Customize Default Login Screen

Create an object that conforms to the [`CelyStyle`](#Cely.CelyStyle) protocol and set it to `.loginStyle` inside of the [`CelyOptions`](#Cely.CelyOptions) dictionary when calling Cely's [`setup(_:)`](#Cely.setup) method.

```swift
// LoginStyles.swift
struct CottonCandy: CelyStyle {
    func backgroundColor() -> UIColor {
        return UIColor(red: 86/255, green: 203/255, blue: 249/255, alpha: 1) // Changing Color
    }
    func buttonTextColor() -> UIColor {
        return .white
    }
    func buttonBackgroundColor() -> UIColor {
    	 return UIColor(red: 253/255, green: 108/255, blue: 179/255, alpha: 1) // Changing Color
    }
    func textFieldBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.4)
    }
    func appLogo() -> UIImage? {
        return UIImage(named: "CelyLogo")
    }
}

...

// AppDelegate.swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    Cely.setup(with: window!, forModel: User.ref, requiredProperties: [.token], withOptions: [
        .loginStyle: CottonCandy(), // <--- HERE!!
        .loginCompletionBlock: { ... }        
    ])

    return true
}

```

#### Use your own Screens
To use your own login screen, simply create a storyboard that contains your login screen and pass that in as `.loginStoryboard` inside of the [`CelyOptions`](#Cely.CelyOptions) dictionary when calling Cely's [`setup(_:)`](#Cely.setup) method. 

Lastly, if your app uses a different storyboard other than `Main.storyboard`, you can pass that in as `.homeStoryboard`.

**⚠️⚠️⚠️⚠️ Be sure to make your Login screen as the `InitialViewController` inside of your storyboard!⚠️⚠️⚠️⚠️**

```swift

// AppDelegate.swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    Cely.setup(with: window!, forModel: User.ref, requiredProperties: [.token], withOptions: [
        .loginStoryboard: UIStoryboard(name: "MyCustomLogin", bundle: nil),
        .homeStoryboard: UIStoryboard(name: "NonMain", bundle: nil)
    ])

    return true
}

```

###Recommended User Pattern

```swift
import Cely

struct User: CelyUser {

    enum Property: CelyProperty {
        case username = "username"
        case email = "email"
        case token = "token"

        func securely() -> Bool {
            switch self {
            case .token:
                return true
            default:
                return false
            }
        }

        func persisted() -> Bool {
            switch self {
            case .username:
                return true
            default:
                return false
            }
        }

        func save(_ value: Any) {
            Cely.save(value, forKey: rawValue, securely: securely(), persisted: persisted())
        }

        func get() -> Any? {
            return Cely.get(key: rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(_ value: Any, as property: Property) {
        property.save(value: value)
    }

    static func save(_ data: [Property : Any]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(_ property: Property) -> Any? {
        return property.get()
    }
}

```

The reason for this pattern is to make saving data as easy as:

```swift
// Pseudo network code, NOT REAL CODE!!!
ApiManager.logUserIn("username", "password") { json in
	let apiToken = json["token"].string
	
	// REAL CODE!!!
	User.save(apiToken, as: .token)
}

```
and getting data as simple as:

```swift
let token = User.get(.token)
```

##API

###Cely
Cely was made to help handle user credentials and handling login with ease. Below you will find documentation for Cely's Framework. **Please do not hesitate to open an issue if something is unclear or is missing.** 
#### Variables
<div id="Cely.store"></div>
##### `store`
A class that conforms to the [`CelyStorageProtocol`](#Cely.CelyStorageProtocol) protocol. By default is set to a singleton instance of `CelyStorage`.


#### Methods

<div id="Cely.setup"></div>
##### `setup(with:forModel:requiredProperties:withOptions:)`
Sets up Cely within your application
<details>
<summary>Example</summary>

```swift
Cely.setup(with: window, forModel: User(), requiredProperties:[.token])

// or 

Cely.setup(with: window, forModel: User(), requiredProperties:[.token], withOptions:[
	.loginStoryboard: UIStoryboard(name: "MyCustomLogin", bundle: nil),
	.HomeStoryboard: UIStoryboard(name: "My_NonMain_Storyboard", bundle: nil),
	.loginCompletionBlock: { (username: String, password: String) in
        if username == "asdf" && password == "asdf" {
            print("username: \(username): password: \(password)")
        }
    }
])
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`window` | `UIWindow` | ✅ | window of your application.
`forModel` | [`CelyUser`](#Cely.CelyUser) | ✅ | The model Cely will be using to store data.
`requiredProperties` | `[CelyProperty]` | no | The properties that cely tests against to determine if a user is logged in. <br> **Default value**: empty array.
`options` | `[CelyOption]` | no | An array of [`CelyOptions`](#Cely.CelyOptions) to pass in additional customizations to cely.

</details>


<div id="Cely.currentLoginStatus"></div>
##### `currentLoginStatus(requiredProperties:fromStorage:)`
Will return the `CelyStatus` of the current user.
<details>
<summary>Example</summary>

```swift
let status = Cely.currentLoginStatus()
```

</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`properties` | [`CelyProperty`] | no | Array of required properties that need to be in store.
`store` | `CelyStorage` | no |    Storage `Cely` will be using. Defaulted to `CelyStorage`

</details>

<details>
<summary>Returns</summary>

Type| Description
----|------
[`CelyStatus`](#Cely.CelyStatus) | If `requiredProperties` are all in store, it will return `.loggedIn`, else `.loggedOut`

</details>


<div id="Cely.get"></div>
##### `get(_:fromStorage:)`
Returns stored data for key.
<details>
<summary>Example</summary>

```swift
let username = Cely.get(key: "username")
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`key` | String | ✅ | The key to the value you want to retrieve.
`store` | CelyStorage | no | Storage `Cely` will be using. Defaulted to `CelyStorage`

</details>

<details>
<summary>Returns</summary>

Type| Description
----|------
`Any?` | Returns an `Any?` object in the case the value nil(not found).

</details>




<div id="Cely.save"></div>
##### `save(_:forKey:toStorage:securely:persisted:)`
Saves data in store
<details>
<summary>Example</summary>

```swift
Cely.save("test@email.com", forKey: "email")
Cely.save("testUsername", forKey: "username", persisted: true)
Cely.save("token123", forKey: "token", securely: true)
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`value` | <code>**Any?**</code> | ✅ | The value you want to save to storage.
`key` | <code>**String**</code> | ✅ | The key to the value you want to save.
`store` | <code>**CelyStorage**</code> | no | Storage `Cely` will be using. Defaulted to `CelyStorage`.
`secure` | <code>**Boolean**</code> | no | If you want to store the value securely.
`persisted` | <code>**Boolean**</code> | no | Keep data after logout.

</details>

<details>
<summary>Returns</summary>

Type| Description
----|------
  `StorageResult` | Whether or not your value was successfully set.

</details>


<div id="Cely.changeStatus"></div>
##### `changeStatus(to:)`
Perform action like `LoggedIn` or `LoggedOut`.
<details>
<summary>Example</summary>

```swift
changeStatus(to: .loggedOut)
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`status` | <code>**CelyStatus**</code> | ✅ | enum value

</details>


<div id="Cely.logout"></div>
##### `logout(usesStorage:)`
Convenience method to logout user. Is equivalent to `changeStatus(to: .loggedOut)`
<details>
<summary>Example</summary>


```swift
Cely.logout()
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`store` | <code>**CelyStorage**</code> | no | Storage `Cely` will be using. Defaulted to `CelyStorage`.

</details>


<div id="Cely.isLoggedIn"></div>
##### `isLoggedIn()`
Returns whether or not the user is logged in
<details>
<summary>Example</summary>

```swift
Cely.isLoggedIn()
```
</details>
<details>
<summary>Returns</summary>

Type| Description
----|------
`Boolean` | Returns whether or not the user is logged in

</details>


### Constants
#### Protocols
<div id="Cely.CelyUser"></div>
##### `CelyUser `
`protocol` for model class to implements

<details>
<summary>Required</summary>

value | Type| Description
----|------|---
`Property ` | `associatedtype` | Enum of all the properties you would like to save for a model

</details>

<div id="Cely.CelyStorageProtocol"></div>
##### `CelyStorageProtocol `
`protocol` a storage class must abide by in order for Cely to use it

<details>
<summary>Required</summary>

```swift
func set(_ value: Any?, forKey key: String, securely secure: Bool, persisted: Bool) -> StorageResult
func get(_ key: String) -> Any?  
func removeAllData()  

```    
</details>

<div id="Cely.CelyStyle"></div>
##### `CelyStyle`
The `protocol` an object must conform to in order to customize Cely's default login screen. Since all methods are optional, Cely will use the default value for any unimplemented methods.

<details>
<summary>Methods</summary>

```swift
func backgroundColor() -> UIColor
func textFieldBackgroundColor() -> UIColor
func buttonBackgroundColor() -> UIColor
func buttonTextColor() -> UIColor
func appLogo() -> UIImage?

```    
</details>

#### Typealias
<div id="Cely.CelyProperty"></div>
##### `CelyProperty `
`String` type alias. Is used in User model

<div id="Cely.CelyCommands"></div>
##### `CelyCommands `
`String` type alias. Command for cely to execute

#### enums
<div id="Cely.CelyOptions"></div>
##### `CelyOptions`
`enum` Options that you can pass into Cely on [`setup(with:forModel:requiredProperties:withOptions:)`](#Cely.setup)

<details>
<summary>Options</summary>

Case ||
----|------|
`storage ` | Pass in you're own storage class if you wish not to use Cely's default storage. Class must conform to the `CelyStorage` protocol.
`homeStoryboard ` | Pass in your app's default storyboard if it is not named "Main"
`loginStoryboard ` | Pass in your own login storyboard.
`loginStyle` | Pass in an object that conforms to [`CelyStyle`](#Cely.CelyStyle) to customize the default login screen.
`loginCompletionBlock ` | `(String,String) -> Void` block of code that will run once the Login button is pressed on Cely's default login Controller

</details>
<div id="Cely.CelyStatus"></div>
##### `CelyStatus`
`enum` Statuses for Cely to perform actions on

<details>
<summary>Statuses</summary>

Case ||
----|------|
`loggedIn ` | Indicates user is now logged in.
`loggedOut ` | Indicates user is now logged out.

</details>

<div id="Cely.StorageResult"></div>
##### `StorageResult `
`enum` result on whether or not Cely successfully saved your data.

<details>
<summary>Results</summary>

Case ||
----|------|
`success ` | Successfully saved your data
`fail(error) ` | Failed to save data along with a `LocksmithError`. 

</details>

## License

Cely is available under the MIT license. See the LICENSE file for more info.
