# keychainsecurity
A Simple Ruby Library That Interacts With macOS Keychain

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)

# Installation:
```
$ git clone https://github.com/krishpranav/keychainsecurity
```

# Usage:
```ruby
require 'keychainsecurity'

KeychainSecurity::Keychain::default_keychain.filename

KeychainSecurity::Keychain.find(server: "itunesconnect.apple.com").password # your password
```