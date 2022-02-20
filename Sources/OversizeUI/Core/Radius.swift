//
// Copyright © 2022 Alexander Romanov
// Radius.swift
//

import SwiftUI

public enum Radius {
    private var theme: ThemeSettings {
        ThemeSettings()
    }

    /// 0
    case zero
    /// 8
    case small
    /// 12
    case medium
    /// 16
    case large
    /// 24
    case xLarge

    public var rawValue: CGFloat {
        switch self {
        case .zero:
            return .zero
        case .small:
            return CGFloat(theme.radius)
        case .medium:
            return theme.radius == .zero ?.zero : CGFloat(theme.radius) * 1.5
        case .large:
            return theme.radius == .zero ?.zero : CGFloat(theme.radius) * 2
        case .xLarge:
            return theme.radius == .zero ?.zero : CGFloat(theme.radius) * 3
        }
    }
}

public struct RadiusModifier: ViewModifier {
    let radius: Radius
    public func body(content: Content) -> some View {
        content.cornerRadius(radius.rawValue)
    }
}

public extension View {
    func cornerRadius(_ radius: Radius) -> some View {
        modifier(RadiusModifier(radius: radius))
    }
}
