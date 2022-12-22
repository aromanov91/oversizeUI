//
// Copyright © 2022 Alexander Romanov
// RowTrailing.swift
//

import SwiftUI

import SwiftUI

public enum RowTrailingType {
    case radio(isOn: Binding<Bool>)
    case checkbox(isOn: Binding<Bool>)
    case toggle(isOn: Binding<Bool>)
    case toggleWithArrowButton(isOn: Binding<Bool>, action: (() -> Void)? = nil)
    @available(watchOS, unavailable)
    case timePicker(date: Binding<Date>)
    case arrowIcon
    case text(_ text: String)
    case button(_ text: String, action: () -> Void)
}

internal struct RowTrailing: View {
    @Environment(\.isPremium) var premiumStatus

    private let type: RowTrailingType
    private let isPremiumOption: Bool

    internal init(_ type: RowTrailingType, isPremiumOption: Bool = false) {
        self.type = type
        self.isPremiumOption = isPremiumOption
    }

    // swiftlint:disable function_body_length
    internal var body: some View {
        switch type {
        case let .toggle(isOn):
            Toggle(isOn: isOn) {}
                .labelsHidden()
                .disabled(isPremiumOption && premiumStatus == false)

        case let .radio(isOn: isOn):
            ZStack {
                Circle()
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(isOn.wrappedValue ? 0 : 1)

                Circle().fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(isOn.wrappedValue ? 1 : 0)

                Circle().fill(Color.white).frame(width: 8, height: 8)
                    .cornerRadius(4)
                    .opacity(isOn.wrappedValue ? 1 : 0)
            }

        case let .checkbox(isOn: isOn):
            ZStack {
                RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                    .strokeBorder(Color.onSurfaceDisabled, lineWidth: 2.5)
                    .frame(width: 24, height: 24)
                    .opacity(isOn.wrappedValue ? 0 : 1)

                RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .opacity(isOn.wrappedValue ? 1 : 0)

                Image(systemName: "checkmark")
                    .font(.caption.weight(.black))
                    .foregroundColor(.onPrimaryHighEmphasis)
                    .opacity(isOn.wrappedValue ? 1 : 0)
            }

        case let .toggleWithArrowButton(isOn: isOn, action: action):
            HStack {
                Toggle(isOn: isOn) {}
                    .labelsHidden()

                Button(action: action ?? {}, label: {
                    Icon(.chevronRight, color: .onSurfaceDisabled)
                })
            }
            .disabled(isPremiumOption && premiumStatus == false)

        case .arrowIcon:
            Icon(.chevronRight, color: .onSurfaceDisabled)

        case let .timePicker(date: date):
            #if os(watchOS)
                EmptyView()
            #elseif os(iOS)
                DatePicker("", selection: date, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            #endif
        case let .text(text):
            Text(text)
                .subheadline()
                .foregroundColor(.onSurfaceMediumEmphasis)

        case let .button(text, action: action):
            Button(text, action: action)
                .buttonStyle(.tertiary)
                .controlBorderShape(.capsule)
                .controlSize(.small)
                .disabled(isPremiumOption && premiumStatus == false)
        }
    }
}
