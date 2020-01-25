**STRUCT**

# `CelyCredentialStore`

```swift
public struct CelyCredentialStore
```

> CelyCredentialStore - object that stores user credentials

## Methods
### `set(username:password:server:accessibility:)`

```swift
public func set(username: String, password: String, server: String, accessibility: [AccessibilityOptions] = []) -> Result<Void, Error>
```

> Set user credentials
> - Parameters:
>   - username: username for user
>   - password: password for user
>   - server: api uri for account
>   - accessibility: Array of AccessibilityOptions for credentials to be saved with

#### Parameters

| Name | Description |
| ---- | ----------- |
| username | username for user |
| password | password for user |
| server | api uri for account |
| accessibility | Array of AccessibilityOptions for credentials to be saved with |

### `get()`

```swift
public func get() -> Result<CelyCredentials, Error>
```

> Return credentials
