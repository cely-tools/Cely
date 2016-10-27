![bitrise status](https://www.bitrise.io/app/aff729145cb46dfe.svg?token=YUV0bymd7P_w2tdiKw2xOQ&branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/chaione/cely/branch/master/graph/badge.svg)](https://codecov.io/gh/chaione/cely)


#Cely (WIP)

Plug-n-Play iOS login framework written in Swift.


## Overview
Cely's goal is to add a login system into your up in under 20 seconds! 

## Background
There are many **How to build a login system for iOS** tutorials on the web that tell you to store credentials in NSUserDefaults, which is incorrect, credentials need to be stored in Keychain. Now working with Keychain is not very fun, that's why Cely is built on top of [Locksmith](https://github.com/matthewpalmer/Locksmith), swift's most popular Keychain wrapper. Cely makes adding a login system to your application as simple as dropping in a UITableView.

###Details:
What does Cely does for you? 

1. Simple API to store user creditials and information **securely**
2. Manages switching between Login Screen and your apps Home Screen
3. Customizable starter Login screen
 
What Cely **does not do** for you? 

1. Network requests
2. Handle Network errors
3. Anything with the network 

# Customizable login screen(WIP)

- textboxes
- background image(and or)color
- email/password keyboard

## Usage

###Setup(20 seconds)

#### User Model (`User.swift`)
Let's start by creating a `User` model that conforms to the [`CelyUser`](#Cely.CelyUser) Protocol:

```swift
// User.swift

import Cely

struct User: CelyUser {

	enum Property : CelyProperty {
		case Token = "token"
	}
}

```
####Login redirect(`AppDelegate.swift`)

Cely's **Simple Setup** function will get you up and running in a matter of seconds. Inside of your `AppDelegate.swift` simply `import Cely` and call the [`setup(_:)`](#Cely.setup) function inside of your `didFinishLaunchingWithOptions` method.

```swift
// AppDelegate.swift

import Cely

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: Any]?) -> Bool {
	
	Cely.setup(with: window, forModel: User(), requiredProperties: [.Token])
	
	...
}
```

**Hit RUN!!**

### Handle LoginCallback
Now how do we get the `username` and `password` from Cely's default LoginViewController? It's easy, just pass in a completion block in the options.

```swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    Cely.setup(with: window!, forModel: User.ref, requiredProperties: [.Token], withOptions: [
        .LoginCompletionBlock: { (username: String, password: String) in
            if username == "asdf" && password == "asdf" {
                Cely.save(username, forKey: "username")
                Cely.save("FAKETOKEN:\(username)\(password)", forKey: "token", securely: true)
                Cely.changeStatus(to: .LoggedIn)
            }
        }
    ])

    return true
}
```

###Recommended User Pattern

```swift
import Cely

struct User: CelyUser {

    enum Property: CelyProperty {
        case Username = "username"
        case Email = "email"
        case Token = "token"

        func securely() -> Bool {
            switch self {
            case .Token:
                return true
            default:
                return false
            }
        }

        func persisted() -> Bool {
            switch self {
            case .Username:
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

    static func save(value: Any, as property: Property) {
        property.save(value: value)
    }

    static func save(data: [Property : Any]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(property: Property) -> Any? {
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
	User.save(apiToken, as: .Token)
}

```
and getting data as simple as:

```swift
let token = User.get(.Token)
```

##API

###Cely
Cely was made to help handle user credentials and handling login with ease. Below you will find documentation for Cely's Framework. 
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
Cely.setup(with: window, forModel: User(), requiredProperties:[.Token])

// or 

Cely.setup(with: window, forModel: User(), requiredProperties:[.Token], withOptions:[
	.LoginStoryboard: UIStoryboard(name: "MyCustomLogin", bundle: nil),
	.HomeStoryboard: UIStoryboard(name: "My_NonMain_Storyboard", bundle: nil),
	.LoginCompletionBlock: { (username: String, password: String) in
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
[`CelyStatus`](#Cely.CelyStatus) | If `requiredProperties` are all in store, it will return `.LoggedIn`, else `.LoggedOut`

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
changeStatus(to: .LoggedOut)
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
Convenience method to logout user. Is equivalent to `changeStatus(to: .LoggedOut)`
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
`Storage ` | Pass in you're own storage class if you wish not to use Cely's default storage. Class must conform to the `CelyStorage` protocol.
`HomeStoryboard ` | Pass in your app's default storyboard if it is not named "Main"
`LoginStoryboard ` | Pass in your own login storyboard.
`LoginCompletionBlock ` | `(String,String) -> Void` block of code that will run once the Login button is pressed on Cely's default login Controller

</details>
<div id="Cely.CelyStatus"></div>
##### `CelyStatus`
`enum` Statuses for Cely to perform actions on

<details>
<summary>Statuses</summary>

Case ||
----|------|
`LoggedIn ` | Indicates user is now logged in.
`LoggedOut ` | Indicates user is now logged out.

</details>

<div id="Cely.StorageResult"></div>
##### `StorageResult `
`enum` result on whether or not Cely successfully saved your data.

<details>
<summary>Results</summary>

Case ||
----|------|
`Success ` | Successfully saved your data
`Fail(error) ` | Failed to save data along with a `LocksmithError`. 

</details>


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

## License

Cely is available under the MIT license. See the LICENSE file for more info.
