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
## Comparison with AsyncImage

AsyncImage is a built-in SwiftUI view introduced in iOS 15 that also allows asynchronous image loading from a URL. Here’s a comparison of AsyncCachedImage and AsyncImage:

### AsyncCachedImage

-    iOS Compatibility: Works with iOS 13+
-    Caching: Explicitly manages image caching using URLCache
-    Customizability: Allows custom content and placeholder views
-    Control: Provides greater control over the image loading process

### AsyncImage

-    iOS Compatibility: Available in iOS 15+
-    Caching: Automatically handles caching
-    Customizability: Limited customization options compared to AsyncCachedImage
-    Control: Easier to use for simple cases, but less control over the loading process

## License
This project is licensed under the [Apache License, Version 2.0](LICENSE).
