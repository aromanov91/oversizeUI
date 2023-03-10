//
// Copyright © 2021 Alexander Romanov
// Select.swift, created on 16.06.2020
//

import SwiftUI

// swiftlint:disable all
public struct Select<Element, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @Environment(\.theme) private var theme: ThemeSettings
    public typealias Data = [Element]

    @Binding private var selection: Data.Element
    private let data: Data
    private let label: String
    private let content: (Data.Element, Bool) -> Content
    @State private var selectedIndex: Data.Index? = 0
    private let selectionView: (Data.Element) -> Selection
    @State private var showModal = false
    @State private var isSelected = false

    public init(_ label: String,
                _ data: Data,
                selection: Binding<Data.Element>,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selectionView: @escaping (Data.Element) -> Selection)
    {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        _selection = selection
    }

    public var body: some View {
        ZStack {
            Button {
                showModal.toggle()
            } label: {
                if isSelected, let index = selectedIndex {
                    selectionView(data[index])
                } else {
                    Text(label)
                }
                Spacer()
                Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
            .headline(.medium)
            .foregroundColor(.onSurfaceHighEmphasis)

            .sheet(isPresented: $showModal) {
                #if os(iOS)
                if #available(iOS 16.0, *) {
                    modal
                        .presentationDetents(data.count < 4 ? [.medium, .large] : [.large])
                        .presentationDragIndicator(.hidden)
                } else {
                    modal
                }
                #else
                modal
                #endif
            }
        }
    }

    private var modal: some View {
        PageView(label) {
            LazyVStack(alignment: .leading, spacing: .zero) {
                ForEach(data.indices, id: \.self) { index in
                    Button(action: {
                               selectedIndex = index
                               selection = data[index]
                               isSelected = true
                               showModal.toggle()
                           },
                           label: {
                               content(data[index],
                                       selectedIndex == index)
                                   .headline()
                                   .onSurfaceHighEmphasisForegroundColor()

                           })
                }
            }
        }
        .leadingBar { BarButton(.close) }
    }
}

// swiftlint:disable all
struct Select_Preview: PreviewProvider {
    struct SelectPreview: View {
        var items = ["One", "Two", "Three", "Four"]

        @State var selection = ""

        var body: some View {
            VStack {
                Select("Select", items, selection: $selection) { item, _ in
                    Text(item)
                } selectionView: { selected in
                    Text(selected)
                }
            }

            .padding()
        }
    }

    static var previews: some View {
        SelectPreview()
            .previewLayout(.sizeThatFits)
    }
}
