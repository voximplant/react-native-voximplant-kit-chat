# Example

Sample host for [`@voximplant/react-native-kit-chat`](../README.md). It initializes the SDK, opens the native chat UI, and lets you pick a Kit region.

This app uses React Native 0.86.2. The SDK itself supports React Native `>= 0.74`; see [Requirements](../README.md#requirements) in the root README.

## Prerequisites

- [React Native environment](https://reactnative.dev/docs/set-up-your-environment) (Android Studio / Xcode, JDK 17)
- Node.js `>= 22.11.0`
- Yarn (this repo is a Yarn workspace)
- A [Voximplant Kit](https://voximplant.com/kit) mobile channel: [create a channel](https://voximplant.com/kit/docs/setup/conversations/channels/mobilechat)

## Install

From the repository root:

```sh
yarn
```

## Run

From `example/`:

```sh
yarn start
```

In another terminal, still in `example/`:

```sh
yarn android
# or
yarn ios
```

These scripts are defined in `example/package.json`.

### iOS

From `example/ios`:

```sh
bundle install
bundle exec pod install
```

Open `VoximplantKitChatExample.xcworkspace` (created by `pod install`), not the `.xcodeproj`.

### Android

Use JDK 17. Edge-to-edge is enabled in the example (`edgeToEdgeEnabled=true`). The sample UI uses a light theme.

## Use the app

1. Select a region.
2. Enter channel UUID, token, and client ID from your Kit mobile channel.
3. Tap **Open chat**.

The app does not persist credentials. Push notification setup is not included here; see the [root README](../README.md) and the [push certificates guide](https://voximplant.com/kit/docs/setup/conversations/pushcertificates).
