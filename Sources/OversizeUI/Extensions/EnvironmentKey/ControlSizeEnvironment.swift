//
// Copyright © 2021 Alexander Romanov
// Created on 28.11.2021
//

import SwiftUI

public enum ControlSize {
    case mini
    case small
    case regular
    @available(macOS 11.0, *)
    case large
}

struct ControlSizeKey: EnvironmentKey {
    public static var defaultValue: ControlSize = .regular
}

public extension EnvironmentValues {
    var controlSize: ControlSize {
        get { self[ControlSizeKey.self] }
        set { self[ControlSizeKey.self] = newValue }
    }
}

public extension View {
    @_disfavoredOverload
    @inlinable func controlSize(_ controlSize: ControlSize) -> some View {
        environment(\.controlSize, controlSize)
    }
}