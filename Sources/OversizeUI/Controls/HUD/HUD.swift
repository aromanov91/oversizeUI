//
// Copyright © 2023 Alexander Romanov
// HUD.swift, created on 22.05.2023
//

import SwiftUI

public struct HUD<Title, Icon>: View where Title: View, Icon: View {
    @Environment(\.screenSize) var screenSize

    private let text: String?
    private let title: Title?
    private let icon: Icon?
    private let isAutoHide: Bool

    @Binding private var isPresented: Bool

    @State private var bottomOffset: CGFloat = 0
    @State private var opacity: CGFloat = 0

    // MARK: Initializers

    public init(
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder title: () -> Title,
        @ViewBuilder icon: () -> Icon
    ) {
        _isPresented = isPresented
        text = nil
        self.title = title()
        self.icon = icon()
        isAutoHide = autoHide
    }

    public var body: some View {
        HStack(spacing: .xSmall) {
            if icon != nil {
                icon
            }
            if let text {
                Text(text)
                    .body(.medium)
                    .foregroundColor(.onSurfaceHighEmphasis)

            } else if let title {
                title
            }
        }
        .padding(.leading, icon == nil ? .medium : .small)
        .padding(.trailing, .medium)
        .padding(.vertical, .xSmall)
        .background(
            Capsule()
                .foregroundColor(Color.surfacePrimary)
                .shadowElevaton(.z2)
        )
        .padding(.small)
        .opacity(opacity)
        .offset(y: bottomOffset)
        .onChange(of: isPresented, perform: { present in
            if present {
                presentAnimated()
            } else {
                dismissAnimated()
            }
        })
    }

    private func presentAnimated() {
        withAnimation {
            bottomOffset = 0
            opacity = 1
        }
        if isAutoHide {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }

    private func dismissAnimated() {
        withAnimation {
            bottomOffset = -200
            opacity = 0
        }
    }
}

public extension HUD where Title == EmptyView, Icon == EmptyView {
    init(
        _ text: String,
        autoHide: Bool = true,
        isPresented: Binding<Bool>
    ) {
        _isPresented = isPresented
        self.text = text
        title = nil
        icon = nil
        isAutoHide = autoHide
    }
}

public extension HUD where Title == EmptyView {
    init(
        _ text: String,
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder icon: () -> Icon
    ) {
        _isPresented = isPresented
        self.text = text
        title = nil
        isAutoHide = autoHide
        self.icon = icon()
    }
}

public extension HUD where Icon == EmptyView {
    init(
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder title: () -> Title
    ) {
        _isPresented = isPresented
        text = nil
        self.title = title()
        icon = nil
        isAutoHide = autoHide
    }
}

public extension View {
    func hud(_ text: String, isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .top) {
            HUD(text, isPresented: isPresented)
        }
    }

    func hud(_ text: String, isPresented: Binding<Bool>, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(text, isPresented: isPresented, icon: icon)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(isPresented: isPresented, title: title)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(isPresented: isPresented, title: title, icon: icon)
        }
    }

    func hudLoader(_ text: String = "Loading", isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .top) {
            HUD(text, autoHide: false, isPresented: isPresented) {
                ProgressView()
            }
        }
    }
}
