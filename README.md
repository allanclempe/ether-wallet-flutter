## Ethereum Wallet for [ERC20](https://en.wikipedia.org/wiki/ERC-20) smart contracts - PREVIEW.

A digital wallet app, developed in dart language and flutter framework. The idea is to have a boiler plate to transfer tokens from one address to another based on smart contracts.

### What's in here

- Built in [Flutter](https://flutter.dev/docs/get-started/install)
- [Google ML Vision](https://firebase.google.com/docs/ml-kit) for QRCode scan.
- [Web3Dart](https://github.com/simolus3/web3dart) to interact with Ethereum blockchain
- [mobx.dart](https://github.com/mobxjs/mobx.dart) for state management

### Getting started

AppConfig.dart file contains contract and network information to access your contract. Do your changes accordantly to your contract.

### Proxy

[iisexpress-proxy](https://www.npmjs.com/package/iisexpress-proxy) is a lightweight proxy. Even tough the main utility for it is to proxy iis express, you can use to proxy **ganache** port.

cmd: `iisexpress-proxy 7545 to 7546`

### Codegen

Build - `flutter packages pub run build_runner build`

Watch - `flutter packages pub run build_runner watch`

### Running

- flutter pub get packages
- flutter run

### Road map

[ ] Handle when connection is not available.
[ ] Better solution to MOBX and form field
[X] Remove contract abi from dart and use the original json file.\
[ ] Change configuration per environment (debug/release)\
[ ] TODO: Contract transactions list\
[ ] Export account private key / display mnemonic\
[X] Use flutter name convention for files, which is lowercase_with_underscores.\
[ ] Change sendTransaction implementation when possible, receiving a stream with confirmations and receipt straight from send method.
[ ] Add support to add use multiple accounts\
[ ] c:\flutter\.pub-cache\hosted\pub.dartlang.org\firebase_analytics-4.0.2\android\src\main\java\io\flutter\plugins\firebaseanalytics\FirebaseAnalyticsPlugin.java uses or overrides a deprecated API

---

Made with ♥ by Allan Clempe ([@aclempe](https://twitter.com/aclempe))

**BTC** 1J95XpMcgMVxVJy52c1h7dtjnbmnsTTCse\
**ETH** 0xe6f6ef26a81f9559fb87154eb5351370bf05606e
