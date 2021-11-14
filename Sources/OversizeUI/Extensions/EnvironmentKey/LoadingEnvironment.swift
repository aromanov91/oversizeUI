//
// Copyright © 2021 Alexander Romanov
// Created on 15.11.2021
//

import SwiftUI

struct LoadingStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingStateKey.self] }
        set { self[LoadingStateKey.self] = newValue }
    }
}

public extension View {
    @ViewBuilder
    func loading(_ isLoading: Bool) -> some View {
        environment(\.isLoading, isLoading)
    }
}
