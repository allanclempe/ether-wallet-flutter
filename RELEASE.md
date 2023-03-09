# Release notes

2.6.0+14:

- Flutter upgraded and tested on version 3.7.2 (dart 2.19.2)
- Polling transaction instead of using listener to get the confirmation (receipt)
- While transfering, enabled a option to open the transaction on the blockchain explorer.
- Ability to transfer contract token or network coin (ETH, BSB or MATIC)
- Using getBlock nodes instead of infura
- Refactored deprecated methods and components
- Displayed balance on the transfer form
- Fixed firebase init on the web
- Libraries upgraded


2.5.0+13:

- Flutter upgraded and tested on version 3.3.7 (dart 2.18.4)
- Upgraded web3dart and provider libraries
- Migrated to goerli testnet

2.4.1+12:

- Flutter upgraded to version 3.0.4 (dart 2.17.5)
- Libraries upgraded 
- fixed black screen on QR code scanner
- added back navbar on the QR code scanner page


2.4.0+11:

- Removed use of deprecated methods
- Web3dart library upgraded
- Stable on Flutter 2.10.5 and dart 2.16.2 (android and ios)

2.3.0+10:

- Flutter upgraded to version 2.8.1 / 2.10 mac (dart 2.15.1) 
- Libraries upgraded and code tweaks to match new contracts.
- Tested on Android and iOS. 

2.2.0+9:

- Web support.

2.1.0+8:

- Flutter upgraded to version 2.2.3 (dart 2.13.4)
- Multi network support (Ethereum, Polygon and BSC)

2.0.0+7:

- Flutter has been upgraded to version 2.0.6 (dart 2.12.3)
- Handled null-safety
- Removed HDKey class [after agreed](https://github.com/alepop/dart-ed25519-hd-key/issues/5) to add master secret as optional parameter in [dart-ed25519-hd-key](https://github.com/alepop/dart-ed25519-hd-key) library. Re-added as dependency.
- Libraries has been upgraded.
- Removed discontinued [firebase_ml_vision](https://pub.dev/packages/firebase_ml_vision) in favor of [qr_code_scanner](https://pub.dev/packages/qr_code_scanner)
- Added menu option to reveal private key

1.3.0+6:

- Flutter has been upgraded to version 2.0.1 (dart 2.12.0).
- Libraries has been upgraded.
- Fixed issue to generate and store private key when imported from seed phrase.

1.2.0+5:

- Flutter has been upgraded to version 1.22 (dart 2.10.5).
- Libraries has been upgraded.
- Small code changes just to get rid of deprecated flutter components.