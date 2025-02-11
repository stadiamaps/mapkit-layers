import MapKit
import CachingMapKitTileOverlay

/// A tile overlay for rendering raster tiles from Stadia Maps.
///
/// This builds upon `MKTileOverlay` but includes better caching.
/// Use with our [caching MapKit tile overlay renderer](https://github.com/stadiamaps/mapkit-caching-tile-overlay).
public class StadiaMapsTileOverlay: MKTileOverlay {
    let apiKey: String
    let style: MapStyle
    let useEUEndpoint: Bool
    // Disk cache of 100MB
    let cache = URLCache(memoryCapacity: 25 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024)
    let urlSession: URLSession
    let cachePolicy: URLRequest.CachePolicy

    /// Creates a new tile overlay with the given API key and style.
    ///
    /// You can optionally force all requests to go to an EU endpoint.
    public init(apiKey: String, style: MapStyle, useEUEndpoint: Bool = false, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) {
        self.apiKey = apiKey
        self.style = style
        self.useEUEndpoint = useEUEndpoint
        self.cachePolicy = cachePolicy

        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        self.urlSession = URLSession(configuration: configuration)

        super.init(urlTemplate: nil)

        self.maximumZ = style.maxZoom
        self.canReplaceMapContent = true
    }

    public override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let host = useEUEndpoint ? "tiles-eu" : "tiles"

        let scale = min(style.maxScale, Int(path.contentScaleFactor))
        let scaleSuffix = scale == 1 ? "" : "@\(scale)x"

        return URL(string: "https://\(host).stadiamaps.com/tiles/\(style.rawValue)/\(path.z)/\(path.x)/\(path.y)\(scaleSuffix).\(style.suffix)?api_key=\(apiKey)")!
    }

    public override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, (any Error)?) -> Void) {
        let url = self.url(forTilePath: path)
        let request = URLRequest(url: url, cachePolicy: cachePolicy)

        if let response = cache.cachedResponse(for: request) {
            result(response.data, nil)
            return
        }

        urlSession.dataTask(with: request) { data, _, error in
            result(data, error)
        }.resume()
    }
}

extension StadiaMapsTileOverlay: CachingTileOverlay {
    public func cachedData(at path: MKTileOverlayPath) -> Data? {
        cache.cachedResponse(for: URLRequest(url: self.url(forTilePath: path)))?.data
    }
}
