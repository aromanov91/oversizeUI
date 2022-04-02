//
// Copyright © 2022 Alexander Romanov
// LocationPicker.swift
//

import MapKit
import SwiftUI

public struct LocationPicker: View {
    @Environment(\.theme) private var theme: ThemeSettings

    private let label: String
    @Binding var coordinates: CLLocationCoordinate2D
    @State var offset = CGPoint(x: 0, y: 0)
    @State private var showModal = false
    @State private var isSelected = false

    public init(label: String, coordinates: Binding<CLLocationCoordinate2D>) {
        self.label = label
        _coordinates = coordinates
    }

    public var body: some View {
        Button {
            self.showModal.toggle()
        } label: {
            HStack(spacing: .xxSmall) {
                Text(label)
                    .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
            }
            Spacer()
            Text(String(coordinates.latitude))
            Text(String(coordinates.longitude))

            Icon(.chevronDown, color: .onSurfaceHighEmphasis)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                             style: .continuous)
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                     style: .continuous)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
        )

        .sheet(isPresented: $showModal) {
            modal
        }
    }

    public var modal: some View {
        ZStack {
            MapView(centerCoordinate: $coordinates)
                .edgesIgnoringSafeArea(.vertical)

            VStack {
                Spacer()

                MaterialSurface {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                }

            }.padding()
        }
        .navigationBar(label, style: .fixed($offset)) {
            BarButton(type: .close)
        } trailingBar: {
            BarButton(type: .secondary("Save", action: {
                isSelected = true
                showModal.toggle()
            }))
        }
    }
}