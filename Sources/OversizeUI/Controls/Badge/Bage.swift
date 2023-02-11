//
// Copyright © 2021 Alexander Romanov
// Bage.swift, created on 20.02.2022
//

import SwiftUI

public struct Bage<Label: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.controlRadius) private var controlRadius: Radius

    private let label: Label
    private let color: Color

    public init(color: Color = .accentColor, @ViewBuilder label: () -> Label) {
        self.color = color
        self.label = label()
    }

    public var body: some View {
        HStack {
            label
                .foregroundColor(color)
                .caption()
        }
        .padding(.vertical, .xxxSmall)
        .padding(.horizontal, 6)
        .background(
            RoundedRectangle(cornerRadius: controlRadius,
                             style: .continuous)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: controlRadius,
                                     style: .continuous)
                        .stroke(
                            theme.borderSurface
                                ? Color.border
                                : Color.clear
                        )
                )
        )
    }
}
