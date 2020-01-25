**PROTOCOL**

# `CelyStorageProtocol`

```swift
public protocol CelyStorageProtocol
```

> Protocol a storage class must abide by in order for Cely to use it

## Methods
### `set(_:forKey:securely:persisted:)`

```swift
func set(_ value: Any?, forKey key: String, securely secure: Bool, persisted persist: Bool) throws
```

### `get(_:)`

```swift
func get(_ key: String) -> Any?
```

### `clearStorage()`

```swift
func clearStorage() throws
```
