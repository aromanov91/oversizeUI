//
// Copyright © 2022 Alexander Romanov
// ElevationEnvironment.swift
//

import SwiftUI

struct ElevationStateKey: EnvironmentKey {
    public static var defaultValue: Elevation = .z0
}

public extension EnvironmentValues {
    var elevation: Elevation {
        get { self[ElevationStateKey.self] }
        set { self[ElevationStateKey.self] = newValue }
    }
}

public extension View {
    @ViewBuilder
    func elevation(_ elevation: Elevation = .z0) -> some View {
        environment(\.elevation, elevation)
    }
}
