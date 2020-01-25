**ENUM**

# `CelyStorageError`

```swift
public enum CelyStorageError: OSStatus, Error
```

## Cases
### `noError`

```swift
case noError = 0
```

### `unimplemented`

```swift
case unimplemented = -4
```

### `diskFull`

```swift
case diskFull = -34
```

### `io`

```swift
case io = -36
```

### `opWr`

```swift
case opWr = -49
```

### `param`

```swift
case param = -50
```

### `wrPerm`

```swift
case wrPerm = -61
```

### `allocate`

```swift
case allocate = -108
```

### `userCanceled`

```swift
case userCanceled = -128
```

### `badReq`

```swift
case badReq = -909
```

### `internalComponent`

```swift
case internalComponent = -2070
```

### `notAvailable`

```swift
case notAvailable = -25291
```

### `readOnly`

```swift
case readOnly = -25292
```

### `authFailed`

```swift
case authFailed = -25293
```

### `noSuchKeychain`

```swift
case noSuchKeychain = -25294
```

### `invalidKeychain`

```swift
case invalidKeychain = -25295
```

### `duplicateKeychain`

```swift
case duplicateKeychain = -25296
```

### `duplicateCallback`

```swift
case duplicateCallback = -25297
```

### `invalidCallback`

```swift
case invalidCallback = -25298
```

### `duplicateItem`

```swift
case duplicateItem = -25299
```

### `itemNotFound`

```swift
case itemNotFound = -25300
```

### `bufferTooSmall`

```swift
case bufferTooSmall = -25301
```

### `dataTooLarge`

```swift
case dataTooLarge = -25302
```

### `noSuchAttr`

```swift
case noSuchAttr = -25303
```

### `invalidItemRef`

```swift
case invalidItemRef = -25304
```

### `invalidSearchRef`

```swift
case invalidSearchRef = -25305
```

### `noSuchClass`

```swift
case noSuchClass = -25306
```

### `noDefaultKeychain`

```swift
case noDefaultKeychain = -25307
```

### `interactionNotAllowed`

```swift
case interactionNotAllowed = -25308
```

### `readOnlyAttr`

```swift
case readOnlyAttr = -25309
```

### `wrongSecVersion`

```swift
case wrongSecVersion = -25310
```

### `keySizeNotAllowed`

```swift
case keySizeNotAllowed = -25311
```

### `noStorageModule`

```swift
case noStorageModule = -25312
```

### `noCertificateModule`

```swift
case noCertificateModule = -25313
```

### `noPolicyModule`

```swift
case noPolicyModule = -25314
```

### `interactionRequired`

```swift
case interactionRequired = -25315
```

### `dataNotAvailable`

```swift
case dataNotAvailable = -25316
```

### `dataNotModifiable`

```swift
case dataNotModifiable = -25317
```

### `createChainFailed`

```swift
case createChainFailed = -25318
```

### `invalidPrefsDomain`

```swift
case invalidPrefsDomain = -25319
```

### `inDarkWake`

```swift
case inDarkWake = -25320
```

### `aclNotSimple`

```swift
case aclNotSimple = -25240
```

### `policyNotFound`

```swift
case policyNotFound = -25241
```

### `invalidTrustSetting`

```swift
case invalidTrustSetting = -25242
```

### `noAccessForItem`

```swift
case noAccessForItem = -25243
```

### `invalidOwnerEdit`

```swift
case invalidOwnerEdit = -25244
```

### `trustNotAvailable`

```swift
case trustNotAvailable = -25245
```

### `unsupportedFormat`

```swift
case unsupportedFormat = -25256
```

### `unknownFormat`

```swift
case unknownFormat = -25257
```

### `keyIsSensitive`

```swift
case keyIsSensitive = -25258
```

### `multiplePrivKeys`

```swift
case multiplePrivKeys = -25259
```

### `passphraseRequired`

```swift
case passphraseRequired = -25260
```

### `invalidPasswordRef`

```swift
case invalidPasswordRef = -25261
```

### `invalidTrustSettings`

```swift
case invalidTrustSettings = -25262
```

### `noTrustSettings`

```swift
case noTrustSettings = -25263
```

### `pkcs12VerifyFailure`

```swift
case pkcs12VerifyFailure = -25264
```

### `invalidCertificate`

```swift
case invalidCertificate = -26265
```

### `notSigner`

```swift
case notSigner = -26267
```

### `policyDenied`

```swift
case policyDenied = -26270
```

### `invalidKey`

```swift
case invalidKey = -26274
```

### `decode`

```swift
case decode = -26275
```

### `internal`

```swift
case `internal` = -26276
```

### `unsupportedAlgorithm`

```swift
case unsupportedAlgorithm = -26268
```

### `unsupportedOperation`

```swift
case unsupportedOperation = -26271
```

### `unsupportedPadding`

```swift
case unsupportedPadding = -26273
```

### `itemInvalidKey`

```swift
case itemInvalidKey = -34000
```

### `itemInvalidKeyType`

```swift
case itemInvalidKeyType = -34001
```

### `itemInvalidValue`

```swift
case itemInvalidValue = -34002
```

### `itemClassMissing`

```swift
case itemClassMissing = -34003
```

### `itemMatchUnsupported`

```swift
case itemMatchUnsupported = -34004
```

### `useItemListUnsupported`

```swift
case useItemListUnsupported = -34005
```

### `useKeychainUnsupported`

```swift
case useKeychainUnsupported = -34006
```

### `useKeychainListUnsupported`

```swift
case useKeychainListUnsupported = -34007
```

### `returnDataUnsupported`

```swift
case returnDataUnsupported = -34008
```

### `returnAttributesUnsupported`

```swift
case returnAttributesUnsupported = -34009
```

### `returnRefUnsupported`

```swift
case returnRefUnsupported = -34010
```

### `returnPersitentRefUnsupported`

```swift
case returnPersitentRefUnsupported = -34011
```

### `valueRefUnsupported`

```swift
case valueRefUnsupported = -34012
```

### `valuePersistentRefUnsupported`

```swift
case valuePersistentRefUnsupported = -34013
```

### `returnMissingPointer`

```swift
case returnMissingPointer = -34014
```

### `matchLimitUnsupported`

```swift
case matchLimitUnsupported = -34015
```

### `itemIllegalQuery`

```swift
case itemIllegalQuery = -34016
```

### `waitForCallback`

```swift
case waitForCallback = -34017
```

### `missingEntitlement`

```swift
case missingEntitlement = -34018
```

### `upgradePending`

```swift
case upgradePending = -34019
```

### `mpSignatureInvalid`

```swift
case mpSignatureInvalid = -25327
```

### `otrTooOld`

```swift
case otrTooOld = -25328
```

### `otrIDTooNew`

```swift
case otrIDTooNew = -25329
```

### `serviceNotAvailable`

```swift
case serviceNotAvailable = -67585
```

### `insufficientClientID`

```swift
case insufficientClientID = -67586
```

### `deviceReset`

```swift
case deviceReset = -67587
```

### `deviceFailed`

```swift
case deviceFailed = -67588
```

### `appleAddAppACLSubject`

```swift
case appleAddAppACLSubject = -67589
```

### `applePublicKeyIncomplete`

```swift
case applePublicKeyIncomplete = -67590
```

### `appleSignatureMismatch`

```swift
case appleSignatureMismatch = -67591
```

### `appleInvalidKeyStartDate`

```swift
case appleInvalidKeyStartDate = -67592
```

### `appleInvalidKeyEndDate`

```swift
case appleInvalidKeyEndDate = -67593
```

### `conversionError`

```swift
case conversionError = -67594
```

### `appleSSLv2Rollback`

```swift
case appleSSLv2Rollback = -67595
```

### `quotaExceeded`

```swift
case quotaExceeded = -67596
```

### `fileTooBig`

```swift
case fileTooBig = -67597
```

### `invalidDatabaseBlob`

```swift
case invalidDatabaseBlob = -67598
```

### `invalidKeyBlob`

```swift
case invalidKeyBlob = -67599
```

### `incompatibleDatabaseBlob`

```swift
case incompatibleDatabaseBlob = -67600
```

### `incompatibleKeyBlob`

```swift
case incompatibleKeyBlob = -67601
```

### `hostNameMismatch`

```swift
case hostNameMismatch = -67602
```

### `unknownCriticalExtensionFlag`

```swift
case unknownCriticalExtensionFlag = -67603
```

### `noBasicConstraints`

```swift
case noBasicConstraints = -67604
```

### `noBasicConstraintsCA`

```swift
case noBasicConstraintsCA = -67605
```

### `invalidAuthorityKeyID`

```swift
case invalidAuthorityKeyID = -67606
```

### `invalidSubjectKeyID`

```swift
case invalidSubjectKeyID = -67607
```

### `invalidKeyUsageForPolicy`

```swift
case invalidKeyUsageForPolicy = -67608
```

### `invalidExtendedKeyUsage`

```swift
case invalidExtendedKeyUsage = -67609
```

### `invalidIDLinkage`

```swift
case invalidIDLinkage = -67610
```

### `pathLengthConstraintExceeded`

```swift
case pathLengthConstraintExceeded = -67611
```

### `invalidRoot`

```swift
case invalidRoot = -67612
```

### `crlExpired`

```swift
case crlExpired = -67613
```

### `crlNotValidYet`

```swift
case crlNotValidYet = -67614
```

### `crlNotFound`

```swift
case crlNotFound = -67615
```

### `crlServerDown`

```swift
case crlServerDown = -67616
```

### `crlBadURI`

```swift
case crlBadURI = -67617
```

### `unknownCertExtension`

```swift
case unknownCertExtension = -67618
```

### `unknownCRLExtension`

```swift
case unknownCRLExtension = -67619
```

### `crlNotTrusted`

```swift
case crlNotTrusted = -67620
```

### `crlPolicyFailed`

```swift
case crlPolicyFailed = -67621
```

### `idpFailure`

```swift
case idpFailure = -67622
```

### `smimeEmailAddressesNotFound`

```swift
case smimeEmailAddressesNotFound = -67623
```

### `smimeBadExtendedKeyUsage`

```swift
case smimeBadExtendedKeyUsage = -67624
```

### `smimeBadKeyUsage`

```swift
case smimeBadKeyUsage = -67625
```

### `smimeKeyUsageNotCritical`

```swift
case smimeKeyUsageNotCritical = -67626
```

### `smimeNoEmailAddress`

```swift
case smimeNoEmailAddress = -67627
```

### `smimeSubjAltNameNotCritical`

```swift
case smimeSubjAltNameNotCritical = -67628
```

### `sslBadExtendedKeyUsage`

```swift
case sslBadExtendedKeyUsage = -67629
```

### `ocspBadResponse`

```swift
case ocspBadResponse = -67630
```

### `ocspBadRequest`

```swift
case ocspBadRequest = -67631
```

### `ocspUnavailable`

```swift
case ocspUnavailable = -67632
```

### `ocspStatusUnrecognized`

```swift
case ocspStatusUnrecognized = -67633
```

### `endOfData`

```swift
case endOfData = -67634
```

### `incompleteCertRevocationCheck`

```swift
case incompleteCertRevocationCheck = -67635
```

### `networkFailure`

```swift
case networkFailure = -67636
```

### `ocspNotTrustedToAnchor`

```swift
case ocspNotTrustedToAnchor = -67637
```

### `recordModified`

```swift
case recordModified = -67638
```

### `ocspSignatureError`

```swift
case ocspSignatureError = -67639
```

### `ocspNoSigner`

```swift
case ocspNoSigner = -67640
```

### `ocspResponderMalformedReq`

```swift
case ocspResponderMalformedReq = -67641
```

### `ocspResponderInternalError`

```swift
case ocspResponderInternalError = -67642
```

### `ocspResponderTryLater`

```swift
case ocspResponderTryLater = -67643
```

### `ocspResponderSignatureRequired`

```swift
case ocspResponderSignatureRequired = -67644
```

### `ocspResponderUnauthorized`

```swift
case ocspResponderUnauthorized = -67645
```

### `ocspResponseNonceMismatch`

```swift
case ocspResponseNonceMismatch = -67646
```

### `codeSigningBadCertChainLength`

```swift
case codeSigningBadCertChainLength = -67647
```

### `codeSigningNoBasicConstraints`

```swift
case codeSigningNoBasicConstraints = -67648
```

### `codeSigningBadPathLengthConstraint`

```swift
case codeSigningBadPathLengthConstraint = -67649
```

### `codeSigningNoExtendedKeyUsage`

```swift
case codeSigningNoExtendedKeyUsage = -67650
```

### `codeSigningDevelopment`

```swift
case codeSigningDevelopment = -67651
```

### `resourceSignBadCertChainLength`

```swift
case resourceSignBadCertChainLength = -67652
```

### `resourceSignBadExtKeyUsage`

```swift
case resourceSignBadExtKeyUsage = -67653
```

### `trustSettingDeny`

```swift
case trustSettingDeny = -67654
```

### `invalidSubjectName`

```swift
case invalidSubjectName = -67655
```

### `unknownQualifiedCertStatement`

```swift
case unknownQualifiedCertStatement = -67656
```

### `mobileMeRequestQueued`

```swift
case mobileMeRequestQueued = -67657
```

### `mobileMeRequestRedirected`

```swift
case mobileMeRequestRedirected = -67658
```

### `mobileMeServerError`

```swift
case mobileMeServerError = -67659
```

### `mobileMeServerNotAvailable`

```swift
case mobileMeServerNotAvailable = -67660
```

### `mobileMeServerAlreadyExists`

```swift
case mobileMeServerAlreadyExists = -67661
```

### `mobileMeServerServiceErr`

```swift
case mobileMeServerServiceErr = -67662
```

### `mobileMeRequestAlreadyPending`

```swift
case mobileMeRequestAlreadyPending = -67663
```

### `mobileMeNoRequestPending`

```swift
case mobileMeNoRequestPending = -67664
```

### `mobileMeCSRVerifyFailure`

```swift
case mobileMeCSRVerifyFailure = -67665
```

### `mobileMeFailedConsistencyCheck`

```swift
case mobileMeFailedConsistencyCheck = -67666
```

### `notInitialized`

```swift
case notInitialized = -67667
```

### `invalidHandleUsage`

```swift
case invalidHandleUsage = -67668
```

### `pvcReferentNotFound`

```swift
case pvcReferentNotFound = -67669
```

### `functionIntegrityFail`

```swift
case functionIntegrityFail = -67670
```

### `internalError`

```swift
case internalError = -67671
```

### `memoryError`

```swift
case memoryError = -67672
```

### `invalidData`

```swift
case invalidData = -67673
```

### `mdsError`

```swift
case mdsError = -67674
```

### `invalidPointer`

```swift
case invalidPointer = -67675
```

### `selfCheckFailed`

```swift
case selfCheckFailed = -67676
```

### `functionFailed`

```swift
case functionFailed = -67677
```

### `moduleManifestVerifyFailed`

```swift
case moduleManifestVerifyFailed = -67678
```

### `invalidGUID`

```swift
case invalidGUID = -67679
```

### `invalidHandle`

```swift
case invalidHandle = -67680
```

### `invalidDBList`

```swift
case invalidDBList = -67681
```

### `invalidPassthroughID`

```swift
case invalidPassthroughID = -67682
```

### `invalidNetworkAddress`

```swift
case invalidNetworkAddress = -67683
```

### `crlAlreadySigned`

```swift
case crlAlreadySigned = -67684
```

### `invalidNumberOfFields`

```swift
case invalidNumberOfFields = -67685
```

### `verificationFailure`

```swift
case verificationFailure = -67686
```

### `unknownTag`

```swift
case unknownTag = -67687
```

### `invalidSignature`

```swift
case invalidSignature = -67688
```

### `invalidName`

```swift
case invalidName = -67689
```

### `invalidCertificateRef`

```swift
case invalidCertificateRef = -67690
```

### `invalidCertificateGroup`

```swift
case invalidCertificateGroup = -67691
```

### `tagNotFound`

```swift
case tagNotFound = -67692
```

### `invalidQuery`

```swift
case invalidQuery = -67693
```

### `invalidValue`

```swift
case invalidValue = -67694
```

### `callbackFailed`

```swift
case callbackFailed = -67695
```

### `aclDeleteFailed`

```swift
case aclDeleteFailed = -67696
```

### `aclReplaceFailed`

```swift
case aclReplaceFailed = -67697
```

### `aclAddFailed`

```swift
case aclAddFailed = -67698
```

### `aclChangeFailed`

```swift
case aclChangeFailed = -67699
```

### `invalidAccessCredentials`

```swift
case invalidAccessCredentials = -67700
```

### `invalidRecord`

```swift
case invalidRecord = -67701
```

### `invalidACL`

```swift
case invalidACL = -67702
```

### `invalidSampleValue`

```swift
case invalidSampleValue = -67703
```

### `incompatibleVersion`

```swift
case incompatibleVersion = -67704
```

### `privilegeNotGranted`

```swift
case privilegeNotGranted = -67705
```

### `invalidScope`

```swift
case invalidScope = -67706
```

### `pvcAlreadyConfigured`

```swift
case pvcAlreadyConfigured = -67707
```

### `invalidPVC`

```swift
case invalidPVC = -67708
```

### `emmLoadFailed`

```swift
case emmLoadFailed = -67709
```

### `emmUnloadFailed`

```swift
case emmUnloadFailed = -67710
```

### `addinLoadFailed`

```swift
case addinLoadFailed = -67711
```

### `invalidKeyRef`

```swift
case invalidKeyRef = -67712
```

### `invalidKeyHierarchy`

```swift
case invalidKeyHierarchy = -67713
```

### `addinUnloadFailed`

```swift
case addinUnloadFailed = -67714
```

### `libraryReferenceNotFound`

```swift
case libraryReferenceNotFound = -67715
```

### `invalidAddinFunctionTable`

```swift
case invalidAddinFunctionTable = -67716
```

### `invalidServiceMask`

```swift
case invalidServiceMask = -67717
```

### `moduleNotLoaded`

```swift
case moduleNotLoaded = -67718
```

### `invalidSubServiceID`

```swift
case invalidSubServiceID = -67719
```

### `attributeNotInContext`

```swift
case attributeNotInContext = -67720
```

### `moduleManagerInitializeFailed`

```swift
case moduleManagerInitializeFailed = -67721
```

### `moduleManagerNotFound`

```swift
case moduleManagerNotFound = -67722
```

### `eventNotificationCallbackNotFound`

```swift
case eventNotificationCallbackNotFound = -67723
```

### `inputLengthError`

```swift
case inputLengthError = -67724
```

### `outputLengthError`

```swift
case outputLengthError = -67725
```

### `privilegeNotSupported`

```swift
case privilegeNotSupported = -67726
```

### `deviceError`

```swift
case deviceError = -67727
```

### `attachHandleBusy`

```swift
case attachHandleBusy = -67728
```

### `notLoggedIn`

```swift
case notLoggedIn = -67729
```

### `algorithmMismatch`

```swift
case algorithmMismatch = -67730
```

### `keyUsageIncorrect`

```swift
case keyUsageIncorrect = -67731
```

### `keyBlobTypeIncorrect`

```swift
case keyBlobTypeIncorrect = -67732
```

### `keyHeaderInconsistent`

```swift
case keyHeaderInconsistent = -67733
```

### `unsupportedKeyFormat`

```swift
case unsupportedKeyFormat = -67734
```

### `unsupportedKeySize`

```swift
case unsupportedKeySize = -67735
```

### `invalidKeyUsageMask`

```swift
case invalidKeyUsageMask = -67736
```

### `unsupportedKeyUsageMask`

```swift
case unsupportedKeyUsageMask = -67737
```

### `invalidKeyAttributeMask`

```swift
case invalidKeyAttributeMask = -67738
```

### `unsupportedKeyAttributeMask`

```swift
case unsupportedKeyAttributeMask = -67739
```

### `invalidKeyLabel`

```swift
case invalidKeyLabel = -67740
```

### `unsupportedKeyLabel`

```swift
case unsupportedKeyLabel = -67741
```

### `invalidKeyFormat`

```swift
case invalidKeyFormat = -67742
```

### `unsupportedVectorOfBuffers`

```swift
case unsupportedVectorOfBuffers = -67743
```

### `invalidInputVector`

```swift
case invalidInputVector = -67744
```

### `invalidOutputVector`

```swift
case invalidOutputVector = -67745
```

### `invalidContext`

```swift
case invalidContext = -67746
```

### `invalidAlgorithm`

```swift
case invalidAlgorithm = -67747
```

### `invalidAttributeKey`

```swift
case invalidAttributeKey = -67748
```

### `missingAttributeKey`

```swift
case missingAttributeKey = -67749
```

### `invalidAttributeInitVector`

```swift
case invalidAttributeInitVector = -67750
```

### `missingAttributeInitVector`

```swift
case missingAttributeInitVector = -67751
```

### `invalidAttributeSalt`

```swift
case invalidAttributeSalt = -67752
```

### `missingAttributeSalt`

```swift
case missingAttributeSalt = -67753
```

### `invalidAttributePadding`

```swift
case invalidAttributePadding = -67754
```

### `missingAttributePadding`

```swift
case missingAttributePadding = -67755
```

### `invalidAttributeRandom`

```swift
case invalidAttributeRandom = -67756
```

### `missingAttributeRandom`

```swift
case missingAttributeRandom = -67757
```

### `invalidAttributeSeed`

```swift
case invalidAttributeSeed = -67758
```

### `missingAttributeSeed`

```swift
case missingAttributeSeed = -67759
```

### `invalidAttributePassphrase`

```swift
case invalidAttributePassphrase = -67760
```

### `missingAttributePassphrase`

```swift
case missingAttributePassphrase = -67761
```

### `invalidAttributeKeyLength`

```swift
case invalidAttributeKeyLength = -67762
```

### `missingAttributeKeyLength`

```swift
case missingAttributeKeyLength = -67763
```

### `invalidAttributeBlockSize`

```swift
case invalidAttributeBlockSize = -67764
```

### `missingAttributeBlockSize`

```swift
case missingAttributeBlockSize = -67765
```

### `invalidAttributeOutputSize`

```swift
case invalidAttributeOutputSize = -67766
```

### `missingAttributeOutputSize`

```swift
case missingAttributeOutputSize = -67767
```

### `invalidAttributeRounds`

```swift
case invalidAttributeRounds = -67768
```

### `missingAttributeRounds`

```swift
case missingAttributeRounds = -67769
```

### `invalidAlgorithmParms`

```swift
case invalidAlgorithmParms = -67770
```

### `missingAlgorithmParms`

```swift
case missingAlgorithmParms = -67771
```

### `invalidAttributeLabel`

```swift
case invalidAttributeLabel = -67772
```

### `missingAttributeLabel`

```swift
case missingAttributeLabel = -67773
```

### `invalidAttributeKeyType`

```swift
case invalidAttributeKeyType = -67774
```

### `missingAttributeKeyType`

```swift
case missingAttributeKeyType = -67775
```

### `invalidAttributeMode`

```swift
case invalidAttributeMode = -67776
```

### `missingAttributeMode`

```swift
case missingAttributeMode = -67777
```

### `invalidAttributeEffectiveBits`

```swift
case invalidAttributeEffectiveBits = -67778
```

### `missingAttributeEffectiveBits`

```swift
case missingAttributeEffectiveBits = -67779
```

### `invalidAttributeStartDate`

```swift
case invalidAttributeStartDate = -67780
```

### `missingAttributeStartDate`

```swift
case missingAttributeStartDate = -67781
```

### `invalidAttributeEndDate`

```swift
case invalidAttributeEndDate = -67782
```

### `missingAttributeEndDate`

```swift
case missingAttributeEndDate = -67783
```

### `invalidAttributeVersion`

```swift
case invalidAttributeVersion = -67784
```

### `missingAttributeVersion`

```swift
case missingAttributeVersion = -67785
```

### `invalidAttributePrime`

```swift
case invalidAttributePrime = -67786
```

### `missingAttributePrime`

```swift
case missingAttributePrime = -67787
```

### `invalidAttributeBase`

```swift
case invalidAttributeBase = -67788
```

### `missingAttributeBase`

```swift
case missingAttributeBase = -67789
```

### `invalidAttributeSubprime`

```swift
case invalidAttributeSubprime = -67790
```

### `missingAttributeSubprime`

```swift
case missingAttributeSubprime = -67791
```

### `invalidAttributeIterationCount`

```swift
case invalidAttributeIterationCount = -67792
```

### `missingAttributeIterationCount`

```swift
case missingAttributeIterationCount = -67793
```

### `invalidAttributeDLDBHandle`

```swift
case invalidAttributeDLDBHandle = -67794
```

### `missingAttributeDLDBHandle`

```swift
case missingAttributeDLDBHandle = -67795
```

### `invalidAttributeAccessCredentials`

```swift
case invalidAttributeAccessCredentials = -67796
```

### `missingAttributeAccessCredentials`

```swift
case missingAttributeAccessCredentials = -67797
```

### `invalidAttributePublicKeyFormat`

```swift
case invalidAttributePublicKeyFormat = -67798
```

### `missingAttributePublicKeyFormat`

```swift
case missingAttributePublicKeyFormat = -67799
```

### `invalidAttributePrivateKeyFormat`

```swift
case invalidAttributePrivateKeyFormat = -67800
```

### `missingAttributePrivateKeyFormat`

```swift
case missingAttributePrivateKeyFormat = -67801
```

### `invalidAttributeSymmetricKeyFormat`

```swift
case invalidAttributeSymmetricKeyFormat = -67802
```

### `missingAttributeSymmetricKeyFormat`

```swift
case missingAttributeSymmetricKeyFormat = -67803
```

### `invalidAttributeWrappedKeyFormat`

```swift
case invalidAttributeWrappedKeyFormat = -67804
```

### `missingAttributeWrappedKeyFormat`

```swift
case missingAttributeWrappedKeyFormat = -67805
```

### `stagedOperationInProgress`

```swift
case stagedOperationInProgress = -67806
```

### `stagedOperationNotStarted`

```swift
case stagedOperationNotStarted = -67807
```

### `verifyFailed`

```swift
case verifyFailed = -67808
```

### `querySizeUnknown`

```swift
case querySizeUnknown = -67809
```

### `blockSizeMismatch`

```swift
case blockSizeMismatch = -67810
```

### `publicKeyInconsistent`

```swift
case publicKeyInconsistent = -67811
```

### `deviceVerifyFailed`

```swift
case deviceVerifyFailed = -67812
```

### `invalidLoginName`

```swift
case invalidLoginName = -67813
```

### `alreadyLoggedIn`

```swift
case alreadyLoggedIn = -67814
```

### `invalidDigestAlgorithm`

```swift
case invalidDigestAlgorithm = -67815
```

### `invalidCRLGroup`

```swift
case invalidCRLGroup = -67816
```

### `certificateCannotOperate`

```swift
case certificateCannotOperate = -67817
```

### `certificateExpired`

```swift
case certificateExpired = -67818
```

### `certificateNotValidYet`

```swift
case certificateNotValidYet = -67819
```

### `certificateRevoked`

```swift
case certificateRevoked = -67820
```

### `certificateSuspended`

```swift
case certificateSuspended = -67821
```

### `insufficientCredentials`

```swift
case insufficientCredentials = -67822
```

### `invalidAction`

```swift
case invalidAction = -67823
```

### `invalidAuthority`

```swift
case invalidAuthority = -67824
```

### `verifyActionFailed`

```swift
case verifyActionFailed = -67825
```

### `invalidCertAuthority`

```swift
case invalidCertAuthority = -67826
```

### `invaldCRLAuthority`

```swift
case invaldCRLAuthority = -67827
```

### `invalidCRLEncoding`

```swift
case invalidCRLEncoding = -67828
```

### `invalidCRLType`

```swift
case invalidCRLType = -67829
```

### `invalidCRL`

```swift
case invalidCRL = -67830
```

### `invalidFormType`

```swift
case invalidFormType = -67831
```

### `invalidID`

```swift
case invalidID = -67832
```

### `invalidIdentifier`

```swift
case invalidIdentifier = -67833
```

### `invalidIndex`

```swift
case invalidIndex = -67834
```

### `invalidPolicyIdentifiers`

```swift
case invalidPolicyIdentifiers = -67835
```

### `invalidTimeString`

```swift
case invalidTimeString = -67836
```

### `invalidReason`

```swift
case invalidReason = -67837
```

### `invalidRequestInputs`

```swift
case invalidRequestInputs = -67838
```

### `invalidResponseVector`

```swift
case invalidResponseVector = -67839
```

### `invalidStopOnPolicy`

```swift
case invalidStopOnPolicy = -67840
```

### `invalidTuple`

```swift
case invalidTuple = -67841
```

### `multipleValuesUnsupported`

```swift
case multipleValuesUnsupported = -67842
```

### `notTrusted`

```swift
case notTrusted = -67843
```

### `noDefaultAuthority`

```swift
case noDefaultAuthority = -67844
```

### `rejectedForm`

```swift
case rejectedForm = -67845
```

### `requestLost`

```swift
case requestLost = -67846
```

### `requestRejected`

```swift
case requestRejected = -67847
```

### `unsupportedAddressType`

```swift
case unsupportedAddressType = -67848
```

### `unsupportedService`

```swift
case unsupportedService = -67849
```

### `invalidTupleGroup`

```swift
case invalidTupleGroup = -67850
```

### `invalidBaseACLs`

```swift
case invalidBaseACLs = -67851
```

### `invalidTupleCredendtials`

```swift
case invalidTupleCredendtials = -67852
```

### `invalidEncoding`

```swift
case invalidEncoding = -67853
```

### `invalidValidityPeriod`

```swift
case invalidValidityPeriod = -67854
```

### `invalidRequestor`

```swift
case invalidRequestor = -67855
```

### `requestDescriptor`

```swift
case requestDescriptor = -67856
```

### `invalidBundleInfo`

```swift
case invalidBundleInfo = -67857
```

### `invalidCRLIndex`

```swift
case invalidCRLIndex = -67858
```

### `noFieldValues`

```swift
case noFieldValues = -67859
```

### `unsupportedFieldFormat`

```swift
case unsupportedFieldFormat = -67860
```

### `unsupportedIndexInfo`

```swift
case unsupportedIndexInfo = -67861
```

### `unsupportedLocality`

```swift
case unsupportedLocality = -67862
```

### `unsupportedNumAttributes`

```swift
case unsupportedNumAttributes = -67863
```

### `unsupportedNumIndexes`

```swift
case unsupportedNumIndexes = -67864
```

### `unsupportedNumRecordTypes`

```swift
case unsupportedNumRecordTypes = -67865
```

### `fieldSpecifiedMultiple`

```swift
case fieldSpecifiedMultiple = -67866
```

### `incompatibleFieldFormat`

```swift
case incompatibleFieldFormat = -67867
```

### `invalidParsingModule`

```swift
case invalidParsingModule = -67868
```

### `databaseLocked`

```swift
case databaseLocked = -67869
```

### `datastoreIsOpen`

```swift
case datastoreIsOpen = -67870
```

### `missingValue`

```swift
case missingValue = -67871
```

### `unsupportedQueryLimits`

```swift
case unsupportedQueryLimits = -67872
```

### `unsupportedNumSelectionPreds`

```swift
case unsupportedNumSelectionPreds = -67873
```

### `unsupportedOperator`

```swift
case unsupportedOperator = -67874
```

### `invalidDBLocation`

```swift
case invalidDBLocation = -67875
```

### `invalidAccessRequest`

```swift
case invalidAccessRequest = -67876
```

### `invalidIndexInfo`

```swift
case invalidIndexInfo = -67877
```

### `invalidNewOwner`

```swift
case invalidNewOwner = -67878
```

### `invalidModifyMode`

```swift
case invalidModifyMode = -67879
```

### `missingRequiredExtension`

```swift
case missingRequiredExtension = -67880
```

### `extendedKeyUsageNotCritical`

```swift
case extendedKeyUsageNotCritical = -67881
```

### `timestampMissing`

```swift
case timestampMissing = -67882
```

### `timestampInvalid`

```swift
case timestampInvalid = -67883
```

### `timestampNotTrusted`

```swift
case timestampNotTrusted = -67884
```

### `timestampServiceNotAvailable`

```swift
case timestampServiceNotAvailable = -67885
```

### `timestampBadAlg`

```swift
case timestampBadAlg = -67886
```

### `timestampBadRequest`

```swift
case timestampBadRequest = -67887
```

### `timestampBadDataFormat`

```swift
case timestampBadDataFormat = -67888
```

### `timestampTimeNotAvailable`

```swift
case timestampTimeNotAvailable = -67889
```

### `timestampUnacceptedPolicy`

```swift
case timestampUnacceptedPolicy = -67890
```

### `timestampUnacceptedExtension`

```swift
case timestampUnacceptedExtension = -67891
```

### `timestampAddInfoNotAvailable`

```swift
case timestampAddInfoNotAvailable = -67892
```

### `timestampSystemFailure`

```swift
case timestampSystemFailure = -67893
```

### `signingTimeMissing`

```swift
case signingTimeMissing = -67894
```

### `timestampRejection`

```swift
case timestampRejection = -67895
```

### `timestampWaiting`

```swift
case timestampWaiting = -67896
```

### `timestampRevocationWarning`

```swift
case timestampRevocationWarning = -67897
```

### `timestampRevocationNotification`

```swift
case timestampRevocationNotification = -67898
```

### `unexpectedError`

```swift
case unexpectedError = -99999
```
