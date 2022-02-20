//
// Copyright © 2022 Alexander Romanov
// Color+RawRepresentable.swift
//

#if os(iOS)
    import Foundation
    import SwiftUI
    import UIKit

    extension Color: RawRepresentable {
        public init?(rawValue: String) {
            guard let data = Data(base64Encoded: rawValue) else {
                self = .blue
                return
            }

            do {
                let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .blue
                self = Color(color)
            } catch {
                self = .black
            }
        }

        public var rawValue: String {
            do {
                // swiftlint:disable line_length
                let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
                return data.base64EncodedString()

            } catch {
                return ""
            }
        }
    }

#endif
