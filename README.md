[![License](https://img.shields.io/github/license/silkodenis/swiftui-async-cached-image.svg)](https://github.com/silkodenis/swiftui-async-cached-image/blob/main/LICENSE)

# AsyncCachedImage

AsyncCachedImage is a SwiftUI view that asynchronously loads and caches an image from a URL, displaying a placeholder while the image is being loaded. This implementation is compatible with iOS 13 and later, providing greater flexibility and control over image loading and caching.

## Features

- Asynchronous image loading from a URL
- Image caching using `URLCache`
- Customizable content and placeholder views
- Compatible with iOS 13 and later

## Requirements

- **iOS 13**+
- **Xcode 11**+
- **Swift 5**+

## Installation

To use `AsyncCachedImage` in your project, simply copy the `AsyncCachedImage.swift` file into your project.

## Usage

Here's an example of how to use `AsyncCachedImage` in your SwiftUI view:

```swift
import SwiftUI

struct ContentView: View {
    let imageUrl = URL(string: "https://example.com/image.jpg")

    var body: some View {
        AsyncCachedImage(url: imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Text("Loading...")
        }
    }
}
```

## License
This project is licensed under the [Apache License, Version 2.0](LICENSE).
