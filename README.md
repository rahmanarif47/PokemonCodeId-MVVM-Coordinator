cat > README.md << 'EOF'
# PokepoCodeId

A sample iOS application built with **Swift, RxSwift, and MVVM architecture**, fetching data from [PokeAPI](https://pokeapi.co).

## Features
- Login & Registration (Local DB)
- Home with Pokémon list (infinite scroll)
- Pokémon detail (name, abilities, image)
- Search Pokémon by name
- Tab navigation: Home & Profile
- Debugging with Wormholy

## Requirements
- Xcode 15+
- iOS 14+
- Swift 5.9+
- CocoaPods

## Installation
```bash
git clone https://github.com/username/PokepoCodeId.git
cd PokepoCodeId
pod install
open PokepoCodeId.xcworkspace

