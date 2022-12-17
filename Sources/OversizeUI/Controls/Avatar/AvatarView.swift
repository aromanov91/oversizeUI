//
// Copyright © 2022 Alexander Romanov
// AvatarView.swift
//

import SwiftUI

public enum AvatarBackgroundType {
    case color(Color), gradient([Color])
}

public struct AvatarView: View {
    @Environment(\.controlSize) var controlSize: ControlSize

    let firstName: String
    let lastName: String
    let avatar: Image?
    var strokeColor: Color = .clear
    var background: AvatarBackgroundType = .color(.surfaceSecondary)
    var onBackgroundColor: Color = .onSurfaceMediumEmphasis

    public init(firstName: String = "",
                lastName: String = "",
                avatar: Image? = nil)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }

    public var body: some View {
        if let avatar {
            avatar
                .resizable()
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
                .overlay(Circle().stroke(strokeColor, lineWidth: 2))

        } else {
            ZStack {
                avatarSurface
                    .frame(width: avatarSize, height: avatarSize)
                    .overlay(Circle().stroke(strokeColor, lineWidth: 2))
                avatarText
            }
        }
    }

    @ViewBuilder
    private var avatarSurface: some View {
        switch background {
        case let .color(color):
            Circle()
                .fill(color)
        case let .gradient(gradientColors):
            Circle()
                .fill(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottom))
        }
    }

    @ViewBuilder
    private var avatarText: some View {
        HStack(spacing: avatarTextSpace) {
            if firstName.isEmpty == false {
                Text(String(firstName.dropLast(firstName.count - 1)).capitalized)
                    .bold()
            }

            if lastName.isEmpty == false {
                Text(String(lastName.dropLast(lastName.count - 1)).capitalized)
                    .bold()
            }
        }
        .font(avatarTextFont)
        .foregroundColor(onBackgroundColor)
    }

    private var avatarTextFont: Font {
        switch controlSize {
        case .mini:
            return .caption
        case .small:
            return .subheadline
        case .regular:
            return .title2
        case .large:
            return .largeTitle
        @unknown default:
            return .title2
        }
    }

    private var avatarTextSpace: CGFloat {
        switch controlSize {
        case .mini:
            return 0
        case .small:
            return 1
        case .regular:
            return 2
        case .large:
            return 2
        @unknown default:
            return 0
        }
    }

    private var avatarSize: CGFloat {
        switch controlSize {
        case .mini:
            return Space.medium.rawValue
        case .small:
            return Space.large.rawValue
        case .regular:
            return Space.xLarge.rawValue
        case .large:
            return Space.xxxLarge.rawValue
        @unknown default:
            return Space.xLarge.rawValue
        }
    }

    public func avatarBackground(_ background: AvatarBackgroundType) -> AvatarView {
        var control = self
        control.background = background
        return control
    }

    public func avatarOnBackground(_ color: Color) -> AvatarView {
        var control = self
        control.onBackgroundColor = color
        return control
    }

    public func avatarStroke(_ strokeColor: Color = .surfacePrimary) -> AvatarView {
        var control = self
        control.strokeColor = strokeColor
        return control
    }
}

// swiftlint:disable all
struct åAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(firstName: "Jhon")
                .controlSize(.small)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith")
                .controlSize(.small)
                .previewDisplayName("First name, last name and storke")

            AvatarView(avatar: Image("empty", bundle: .module))
                .controlSize(.small)
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty", bundle: .module))
                .controlSize(.small)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 24, height: 24))
            .background(Color.surfaceTertiary)

        Group {
            AvatarView(firstName: "Jhon")
                .controlSize(.regular)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith")
                .controlSize(.regular)
                .previewDisplayName("First name, last name and storke")

            AvatarView(avatar: Image("empty", bundle: .module))
                .controlSize(.regular)
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty", bundle: .module))
                .controlSize(.regular)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 48, height: 48))
            .background(Color.surfaceTertiary)

        Group {
            AvatarView(firstName: "Jhon")
                .controlSize(.large)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith")
                .controlSize(.large)
                .previewDisplayName("First name, last name and storke")

            AvatarView(avatar: Image("empty", bundle: .module))
                .controlSize(.large)
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty", bundle: .module))
                .controlSize(.large)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 96, height: 96))
            .background(Color.surfaceTertiary)
    }
}
