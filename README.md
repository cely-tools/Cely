#Cely 

Plug-n-Play iOS login framework written in Swift.


## Overview
Cely's goal is to add a login system into your up in under 20 seconds! 

## Background
There are many **How to build a login system for iOS** tutorials on the web that tell you to store credentials in NSUserDefaults, which is incorrect, credentials need to be stored in Keychain. Now working with Keychain is not very fun, that's why Cely is built on top of [Locksmith](https://github.com/matthewpalmer/Locksmith), swift's most popular Keychain wrapper. 

###Details:
What does Cely does for you? 

1. Simple API to store user creditials and information **securely**
2. Manages switching between Login Screen and your apps Home Screen
3. Customizable starter Login screen
 
What does Cely **does not do** for you? 

1. Network requests
2. Handle Network errors
3. Anything with the network 

# Customizable login screen

- textboxes
- background image(and or)color
- email/password keyboard
- New cely user protocol??
   - username
   - password

## Usage

###Setup(20 seconds)

#### User Model (`User.swift`)
Let's start by creating a `User` model that conforms to the `CelyUser`(Link it) Protocol:

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

Cely's **Simple Setup** function will get you up and running in a matter of seconds. Inside of your `AppDelegate.swift` simply `import Cely` and call the `setup(_:)` function inside of your `didFinishLaunchingWithOptions` method.

```swift
// AppDelegate.swift

import Cely

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: Any]?) -> Bool {
	
	Cely.setup(with: window, forModel: User(), requiredProperties: [.Token])
	
	...
}
```

**Hit RUN!!**

## Example
#<#Get data from login controller(Delegate)>
###Recommended User Pattern

```swift
import Cely

struct User: CelyUser {

    private init() {}
    static let instance = User() // singleton reference

    enum Property: CelyProperty {
        case Username = "username"
        case Email = "email"
        case Token = "token"

        func save(_ value: Any) {
            Cely.save(value, forKey: self.rawValue)
        }

        func get() -> Any? {
            return Cely.get(key: self.rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(_ value: Any, as property: Property) {
        property.save(value)
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
	User.save(apiToken, as: .Token)
}

```
and getting data as simple as:

```swift
let token = User.get(.Token)
```

##API

### Variables
#### `store`
A [`CelyStorage`[LINK!!]](asdf) instance. 

store |
-----|----
Default Value | singleton instance of `CelyStorage`


### Methods

#### `setup(with:forModel:requiredProperties:)`
Sets up Cely within your application
<details>
<summary>Example</summary>
```swift
Cely.setup(with: window, forModel: User(), requiredProperties:[.Token])
```
</details>
<details>
<summary>Parameters</summary>

Key | Type| Required? | Description
----|------|----------|--------
`window` | `UIWindow` | ✅ | window of your application.
`forModel` | [`CelyUser`[LINK]](asd) | ✅ | The model Cely will be using to store data.
`requiredProperties` | `[CelyProperty[LINK]]` | no | The properties that cely tests against to determine if a user is logged in. <br> **Default value**: empty array.

</details>


#### `currentLoginStatus(requiredProperties:fromStorage:)`
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
`properties` | [CelyProperty] | no | Array of required properties that need to be in store.
`store` | CelyStorage | no |    Storage `Cely` will be using. Defaulted to `CelyStorage`

</details>

<details>
<summary>Returns</summary>

Type| Description
----|------
`CelyStatus` | If `requiredProperties` are all in store, it will return `.LoggedIn`, else `.LoggedOut`

</details>


#### `get(_:fromStorage:)`
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




#### `save(_:forKey:toStorage:securely:)`
Saves data in store
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
`value` | <code>**Any?**</code> | ✅ | The value you want to save to storage.
`key` | <code>**String**</code> | ✅ | The key to the value you want to save.
`store` | <code>**CelyStorage**</code> | no | Storage `Cely` will be using. Defaulted to `CelyStorage`.
`secure` | <code>**Boolean**</code> | no | If you want to store the value securely.

</details>

<details>
<summary>Returns</summary>

Type| Description
----|------
  `StorageResult` | Whether or not your value was successfully set.

</details>





#### `changeStatus(to:)`
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


#### `logout(usesStorage:)`
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


#### `isLoggedIn()`
Returns whether or not the user is logged in
<details>
<summary>Example</summary>
```swift
Cely.logout()
```
</details>
<details>
<summary>Returns</summary>

Type| Description
----|------
`Boolean` | Returns whether or not the user is logged in

</details>



## Requirements
- Xcode 8
- swift 3.0

## Installation

###Carthage
```
github "initFabian/Cely"
```
Cely will also include [`Locksmith`](https://github.com/matthewpalmer/Locksmith) when you import it into your project, so be sure to add `Locksmith` in your copy phase script.

> $(SRCROOT)/Carthage/Build/iOS/Cely.framework
> $(SRCROOT)/Carthage/Build/iOS/Locksmith.framework
####Keychain entitlement Part(Xcode 8 bug?)
Be sure to [turn on Keychain entitlements](http://stackoverflow.com/a/31421742/1973339) for your app, not doing so will prevent Cely from saving data to the keychain. 

## License

Cely is available under the MIT license. See the LICENSE file for more info.