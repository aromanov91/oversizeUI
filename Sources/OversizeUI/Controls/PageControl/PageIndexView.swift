//
// Copyright © 2021 Alexander Romanov
// PageIndexView.swift, created on 09.09.2022
//

import SwiftUI

public struct PageIndexView: View {
    private var index: Int
    private let maxIndex: Int

    public init(_ index: Int, maxIndex: Int) {
        self.index = index
        self.maxIndex = maxIndex
    }

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< maxIndex, id: \.self) { index in
                Capsule()
                    .fill(index == self.index ? Color.accent : Color.surfaceTertiary)
                #if os(iOS)
                    .frame(width: index == self.index ? 28 : 8, height: 8)
                #else
                    .frame(width: index == self.index ? 24 : 6, height: 6)
                #endif
                    .animation(.default, value: index)
            }
        }
        .padding(12)
        .animation(.default, value: index)
    }
}
