public enum MapStyle: String {
    case alidadeSmooth = "alidade_smooth"
    case alidadeSmoothDark = "alidade_smooth_dark"
    case alidadeSatellite = "alidade_satellite"
    case outdoors = "outdoors"

    case stamenToner = "stamen_toner"
    case stamenTerrain = "stamen_terrain"
    case stamenWatercolor = "stamen_watercolor"

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
