**STRUCT**

# `Cely`

```swift
public struct Cely
```

## Methods
### `setup(with:forModel:requiredProperties:withOptions:)`

```swift
public static func setup<T: CelyUser, U>(with window: UIWindow?, forModel _: T, requiredProperties: [U] = [], withOptions options: [CelyOptions: Any?]? = [:]) where T.Property == U
```

> Sets up Cely within your application
>
> - parameter window:             `UIWindow` of your application.
> - parameter forModel:           The `Model` Cely will be storing.
> - parameter requiredProperties: `[CelyProperty]`: The properties that cely tests against to determine if a user is logged in.
> - parameter withOptions:         Dictionary of options to pass into cely upon setup. Please refer to `CelyOptions` to view all options.

#### Parameters

| Name | Description |
| ---- | ----------- |
| window | `UIWindow` of your application. |
| forModel | The `Model` Cely will be storing. |
| requiredProperties | `[CelyProperty]`: The properties that cely tests against to determine if a user is logged in. |
| withOptions | Dictionary of options to pass into cely upon setup. Please refer to `CelyOptions` to view all options. |

### `currentLoginStatus(requiredProperties:fromStorage:)`

```swift
public static func currentLoginStatus(requiredProperties properties: [CelyProperty] = requiredProperties, fromStorage store: CelyStorageProtocol = store) -> CelyStatus
```

> Will return the `CelyStatus` of the current user.
> - Parameters:
>   - properties: Array of required properties that need to be in store.
>   - store: Storage `Cely` will be using. Defaulted to `Storage`
> - returns: `CelyStatus`. If `requiredProperties` are all in store, it will return `.LoggedIn`, else `.LoggedOut`

#### Parameters

| Name | Description |
| ---- | ----------- |
| properties | Array of required properties that need to be in store. |
| store | Storage `Cely` will be using. Defaulted to `Storage` |

### `get(key:fromStorage:)`

```swift
public static func get(key: String, fromStorage store: CelyStorageProtocol = store) -> Any?
```

> Returns stored data for key.
>
> - parameter key:    String
> - parameter store: Object that conforms to the CelyStorageProtocol protocol that `Cely` will be using. Defaulted to `Cely`'s instance of store
>
> - returns: Returns data as an optional `Any`

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | String |
| store | Object that conforms to the CelyStorageProtocol protocol that `Cely` will be using. Defaulted to `Cely`’s instance of store |

### `save(_:forKey:toStorage:securely:persisted:)`

```swift
public static func save(_ value: Any?, forKey key: String, toStorage store: CelyStorageProtocol = store, securely secure: Bool = false, persisted persist: Bool = false) -> Result<Void, Error>
```

> Saves data in store
>
> - parameter value:   data you want to save
> - parameter key:     String for the key
> - parameter store: Storage `Cely` will be using. Defaulted to `Storage`
> - parameter secure: `Boolean`: Store data securely
> - parameter persist: `Boolean`: Keep data after logout
>
> - returns: `Boolean`: Whether or not your value was successfully set.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | data you want to save |
| key | String for the key |
| store | Storage `Cely` will be using. Defaulted to `Storage` |
| secure | `Boolean`: Store data securely |
| persist | `Boolean`: Keep data after logout |

### `changeStatus(to:)`

```swift
public static func changeStatus(to status: CelyStatus)
```

> Perform action like `LoggedIn` or `LoggedOut`
>
> - parameter status: CelyStatus

#### Parameters

| Name | Description |
| ---- | ----------- |
| status | CelyStatus |

### `logout(useStorage:)`

```swift
public static func logout(useStorage store: CelyStorageProtocol = store) -> Result<Void, Error>
```

> Log user out
>
> - parameter store: Storage `Cely` will be using. Defaulted to `CelyStorageProtocol`

#### Parameters

| Name | Description |
| ---- | ----------- |
| store | Storage `Cely` will be using. Defaulted to `CelyStorageProtocol` |

### `isLoggedIn()`

```swift
public static func isLoggedIn() -> Bool
```

> Returns whether or not the user is logged in
>
> - returns: `Boolean`
