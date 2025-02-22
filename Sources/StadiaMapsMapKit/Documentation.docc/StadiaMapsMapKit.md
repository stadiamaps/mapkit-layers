# ``StadiaMapsMapKit``

Making it easy to add raster layers from Stadia Maps to your MapKit project.

## Overview

This project includes subclasses of `MKOverlay` and `MKOverlayRenderer`
to streamline integrations with Stadia Maps raster tile layers into MapKit apps.

Here's a minimal example of how to use this with an `MKMapView` on iOS.

```swift
import UIKit
import MapKit
import CachingMapKitTileOverlay
import StadiaMapsMapKit

// FIXME: Replace with your API key. Get one for free at client.stadiamaps.com
let stadiaApiKey = "YOUR-API-KEY"
class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let overlay = StadiaMapsTileOverlay(apiKey: stadiaApiKey, style: .stamenTerrain)
        mapView.addOverlay(overlay, level: .aboveLabels)
    }

}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let cachingOverlay = overlay as? CachingTileOverlay {
            return CachingTileOverlayRenderer(overlay: cachingOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
```

## Topics

### Classes

- ``StadiaMapsTileOverlay``

### Enums

- ``MapStyle``
