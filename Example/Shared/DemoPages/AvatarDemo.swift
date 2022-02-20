//
// Copyright © 2022 Alexander Romanov
// AvatarDemo.swift
//

import OversizeUI
import SwiftUI

struct AvatarDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
                AvatarView(firstName: "Jhon", size: .small)

                AvatarView(firstName: "Jhon", lastName: "Smith", size: .small, stroke: true)

                AvatarView(firstName: "Jhon", size: .m)

                AvatarView(firstName: "Jhon", lastName: "Smith", size: .m, stroke: true)

                AvatarView(firstName: "Jhon", size: .l)

                AvatarView(firstName: "Jhon", lastName: "Smith", size: .l, stroke: true)
            }
        }
        .navigationBarTitle("Avatar", displayMode: .inline)
    }
}

struct AvatarDemo_Previews: PreviewProvider {
    static var previews: some View {
        AvatarDemo()
    }
}
