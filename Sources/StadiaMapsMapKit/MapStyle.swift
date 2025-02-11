/// A basemap style from Stadia Maps.
public enum MapStyle: String {
    /// Designed for maps that use a lot of markers or overlays.
    /// This style is the ideal canvas for maps featuring a lot of data layers.
    /// With a muted color scheme and fewer points of interest, Alidade Smooth lives to make your data shine.
    case alidadeSmooth = "alidade_smooth"

    /// Alidade Smooth Dark, like its lighter cousin, is  designed to stay out of the way
    ///  It just flips the dark mode switch on the color scheme. With the lights out, your data can now *iterally* shine.
    case alidadeSmoothDark = "alidade_smooth_dark"

    /// With fresh, brilliant, and sharp imagery, the Alidade Satellite style turns planet earth into your canvas.
    /// This style uses satellite and aerial imagery as a base,
    /// and layers labels and outlines of major features on top to create a solid contextual backdrop for your data.
    case alidadeSatellite = "alidade_satellite"
    /// Make the great outdoors your playground.
    /// Stadia Outdoors highlights a moderate number of features,
    /// adds useful outdoor features such as ski slopes not found on other styles,
    /// and displays natural features such as mountains, parks, and paths.
    case outdoors = "outdoors"

    /// The most popular of the excellent styles from Stamen Design,
    /// these high-contrast B+W (black and white) maps are the perfect backdrop
    /// for your colorful and eye-catching overlays.
    case stamenToner = "stamen_toner"

    /// Orient yourself with Stamen terrain maps,
    /// featuring hill shading and natural vegetation colors.
    case stamenTerrain = "stamen_terrain"

    /// Reminiscent of hand drawn maps,
    /// the watercolor maps from Stamen Design apply raster effect area washes and organic edges
    /// over a paper texture to add warm pop to any map.
    case stamenWatercolor = "stamen_watercolor"

    /// The OSM Bright style was developed as a sensible starting point for quickly making beautiful maps
    /// based on the OpenStreetMap database.
    /// It highlights the content of the map itself.
    case osmBright = "osm_bright"
}

extension MapStyle {
    var suffix: String {
        switch self {
        case .alidadeSatellite, .stamenWatercolor: "jpg"
        default: "png"
        }
    }

    var maxZoom: Int {
        switch self {
        case .stamenWatercolor:
            18
        default:
            20
        }
    }

    var maxScale: Int {
        switch self {
        case .stamenWatercolor:
            1
        default:
            2
        }
    }
}
