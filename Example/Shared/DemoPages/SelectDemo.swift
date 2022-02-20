//
// Copyright © 2022 Alexander Romanov
// SelectDemo.swift
//

import OversizeUI
import SwiftUI

struct SelectDemo: View {
    var items = ["One", "Two", "Three", "Four"]

    @State var selection = ""

    var body: some View {
        VStack {
            Select("Select", items, selection: $selection) { item, _ in
                Text(item)
            } selectionView: { selected in
                Text(selected)
            }
            .previewDisplayName("Default")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct SelectDemo_Previews: PreviewProvider {
    static var previews: some View {
        SelectDemo()
    }
}
