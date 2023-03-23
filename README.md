## Getting started with SwiftUI and Replicate

This is a [SwiftUI](https://developer.apple.com/xcode/swiftui/) template project for working with Replicate's API.

You can use this as a quick jumping-off point to build an app using Replicate's API, or you can recreate this codebase from scratch by following the guide at [replicate.com/docs/get-started/swiftui](https://replicate.com/docs/get-started/swiftui)

## Noteworthy files

- [ContentView.swift](ContentView.swift) - The main content view of the app, including the Replicate API client

## Usage

Open with Xcode

```console
xed .
```

Provide your [Replicate API token](https://replicate.com/account#token)

```
private var client = Replicate.Client(token: <#token#>)
```

> **Warning**
>
> Don't store secrets in code or any other resources bundled with your app.
> Instead, fetch them from CloudKit or another server and store them in the keychain.
>
> See:
>
> - [`fetch(withRecordID:completionHandler:)` reference](https://developer.apple.com/documentation/cloudkit/ckdatabase/1449126-fetch)
> - ["Storing Keys in the Keychain"](https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_keychain)

In Xcode, go to the "Product" menu and select "Run" (<kbd>⌘</kbd><kbd>R</kbd>)

For detailed instructions on how to create and use this template, see [replicate.com/docs/get-started/swiftui](https://replicate.com/docs/get-started/swiftui)

![Example image generated with prompt "renaissance portrait of a figure holding an iPhone"](https://user-images.githubusercontent.com/7659/227384901-5bae4745-8e82-4fa9-aa40-ddd3b968adf5.png)
