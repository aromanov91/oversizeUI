//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

import SwiftUI

// swiftlint:disable opening_brace
public extension View {
    func surface(elevation: Elevation = .z0,
                 background: SurfaceColor = .primary,
                 padding: SurfacePadding = .medium,
                 radius: Radius = .medium) -> some View
    {
        Surface(background: background,
                padding: padding,
                radius: radius) { self }
            .elevation(elevation)
    }

    func surface(elevation: Elevation) -> some View {
        Surface(background: .primary,
                padding: .medium,
                radius: .medium) { self }
            .elevation(elevation)
    }

    func surface(elevation: Elevation, background: SurfaceColor) -> some View {
        Surface(background: background,
                padding: .medium,
                radius: .medium) { self }
            .elevation(elevation)
    }
}
