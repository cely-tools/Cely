# Introduction

This is a quick guide on how to deploy the Cely Swift Framework. You will need to have [cocoapods](https://cocoapods.org/) installed along with being registered with [trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html) and having permissions to deploy new versions of Cely.

# Bumping Version

Bumping a version should happen on its own pull request(commit) separate from any features or bug fixes, unless these fixes are for making the Cely framework compatible with newer versions of Swift or Xcode. I.E. a pull request to make Cely Swift 5 compatible.

Here is a checklist of files that will need to be updated when releasing a new version:

#### README.md

>To integrate Cely into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Cely', '~> <NEW_VERSION>'
```

...

>To integrate Cely into your Xcode project using Carthage, specify it in your Cartfile:
```
github "initFabian/Cely" ~> <NEW_VERSION>
```

#### `Cely.podspec`

```ruby
Pod::Spec.new do |spec|
  spec.swift_version = '4.2' # new swift version
  spec.name = 'Cely'
  spec.version = '<NEW_VERSION>'
```


#### `.swift-version`

if we are updating to a new Swift version, please update this file.


# Deploy

## Tagging

Once the pull request containing the changes for the version bump is merged in, tag a new version on Github. For consistency purposes, please use the format, `X.X.X`, ~~**NOT `vX.X.X`**~~.

## Carthage

Since carthage uses Github's tagging system, no additional work other than tagging a release is necessary.

## Cocoapods

Cocoapods uses its own repository to store new releases(`podspec`) of Frameworks. It uses its command-line tool [trunk](https://blog.cocoapods.org/CocoaPods-Trunk/) to handle deploying. If you would like to get started with trunk, please checkout this [getting started article](https://guides.cocoapods.org/making/getting-setup-with-trunk.html).

Before deploying, run cocoapods linting tool to quickly verify you have no mistakes in your `podspec` file. Trunk will still eventually run this command before pushing up a new version, but running it separately will yield quicker results.

In the root directory of the Cely project, run the following:
```sh
$ pod spec lint Cely.podspec
```

example error:

```sh
-> Cely.podspec
    - ERROR | spec: The specification defined in `Cely.podspec` could not be loaded.


[!] Invalid `Cely.podspec` file: undefined method `nafme=' for #<Pod::Specification name=nil>
Did you mean?  name=
               name.

 #  from /Users/fabianBuentello/Development/iOS/Cely/Cely.podspec:3
 #  -------------------------------------------
 #    spec.swift_version = '4.2'
 >    spec.nafme = 'Cely'
 #    spec.version = '2.1.0'
 #  -------------------------------------------


Analyzed 1 podspec.
```

If the linting succeeds, then in order to deploy run the following command:

```
pod trunk push Cely.podspec
```


### Cocoapods troubleshooting

If your trunk session is expired, you will be asked to reauthenticate. You will run the command below. Afterwards, you will receive an email from `no-reply@cocoapods.org` with a link to confirm your session. Click on the link and you should be good to go.

```sh
$ pod trunk register <email>
```

If you are not sure if your session has expired, you can run the following command:

```sh
$ pod trunk me
```

**Fail on warnings**

Depending on your version of cocoapods, it may not recognize the property `swift_version` inside of `Cely.podspec`. As mentioned in issue [\#8635](https://github.com/CocoaPods/CocoaPods/issues/8635), a workaround for this is to append the `--allow-warnings` flag when pushing. This issue should be getting resolved with cocoapods v1.7.

```sh
$ pod trunk push Cely.podspec --allow-warnings
```

---

Here are the `--help` options:

```sh
$ pod trunk --help
Usage:

    $ pod trunk COMMAND

      Interact with the CocoaPods API (e.g. publishing new specs)

Commands:

    + add-owner      Add an owner to a pod
    + delete         Deletes a version of a pod.
    + deprecate      Deprecates a pod.
    + info           Returns information about a Pod.
    + me             Display information about your sessions
    + push           Publish a podspec
    + register       Manage sessions
    + remove-owner   Remove an owner from a pod

Options:

    --silent         Show nothing
    --verbose        Show more debugging information
    --no-ansi        Show output without ANSI codes
    --help           Show help banner of specified command
```
