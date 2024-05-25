/*
 * Copyright (c) [2024] [Denis Silko]
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *     https://github.com/silkodenis/swiftui-async-cached-image
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI
import Combine

/// A view that asynchronously loads and caches an image from a URL,
/// displaying a placeholder while the image is being loaded.
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    private let url: URL?
    private let content: (Image) -> ImageView
    private let placeholder: () -> PlaceholderView
    @State private var image: UIImage? = nil
    @State private var cancellable: AnyCancellable?

    /// Initializes the AsyncCachedImage with a URL, content view, and placeholder view.
    ///
    /// - Parameters:
    ///   - url: The URL to load the image from.
    ///   - content: A view builder that takes a loaded `Image` and returns the view to display.
    ///   - placeholder: A view builder that provides the placeholder view to display while the image is loading.
    init(url: URL?,
         @ViewBuilder content: @escaping (Image) -> ImageView,
         @ViewBuilder placeholder: @escaping () -> PlaceholderView) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear(perform: loadImage)
                    .onDisappear(perform: cancelLoading)
            }
        }
    }
    
    // MARK: - Private

    /// Loads the image from the URL asynchronously, using a cached image if available.
    private func loadImage() {
        guard let url = url else { return }

        if let cachedImage = loadCachedImage(for: url) {
            self.image = cachedImage
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                self.cacheImage(data, response: response, for: url)
                return UIImage(data: data)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    /// Cancels the image loading task.
    private func cancelLoading() {
        cancellable?.cancel()
    }

    /// Loads the cached image for a given URL, if available.
    ///
    /// - Parameter url: The URL of the image to load from cache.
    /// - Returns: The cached `UIImage`, or `nil` if no cached image is available.
    private func loadCachedImage(for url: URL) -> UIImage? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }

    /// Caches the image data for a given URL.
    ///
    /// - Parameters:
    ///   - data: The image data to cache.
    ///   - response: The URL response associated with the image data.
    ///   - url: The URL of the image to cache.
    private func cacheImage(_ data: Data, response: URLResponse, for url: URL) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
}
