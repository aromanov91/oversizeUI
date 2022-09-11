//
// Copyright © 2022 Alexander Romanov
// IconStyleEnvironment.swift
//

import SwiftUI

public enum IconStyle {
    case line, solid, duotone
}

private struct IconStyleKey: EnvironmentKey {
    public static var defaultValue: IconStyle = .line
}

public extension EnvironmentValues {
    var iconStyle: IconStyle {
        get { self[IconStyleKey.self] }
        set { self[IconStyleKey.self] = newValue }
    }
}

public extension View {
    func iconStyle(_ iconStyle: IconStyle) -> some View {
        environment(\.iconStyle, iconStyle)
    }
}