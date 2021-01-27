//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//  Documentation
//  https://jessesquires.github.io/WrappedDefaults
//
//  GitHub
//  https://github.com/jessesquires/WrappedDefaults
//
//  Copyright © 2021-present Jesse Squires
//

import Foundation

/// Describes a value that can be saved to and fetched from `UserDefaults`.
public protocol UserDefaultsSerializable {

    /// The type of the value that is stored in `UserDefaults`.
    associatedtype StoredValue

    /// The value to store in `UserDefaults`.
    var storedValue: StoredValue { get }

    /// Initializes the object using the provided value.
    /// - Parameter storedValue: The previously store value fetched from `UserDefaults`.
    init(storedValue: StoredValue)
}

/// :nodoc:
extension Bool: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension Int: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension Float: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension Double: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension String: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension URL: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension Date: UserDefaultsSerializable {
    public var storedValue: TimeInterval {
        self.timeIntervalSince1970
    }

    public init(storedValue: TimeInterval) {
        self = Date(timeIntervalSince1970: storedValue)
    }
}

/// :nodoc:
extension Data: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

/// :nodoc:
extension Array: UserDefaultsSerializable where Element: UserDefaultsSerializable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = storedValue.map { Element(storedValue: $0) }
    }
}

/// :nodoc:
extension Set: UserDefaultsSerializable where Element: UserDefaultsSerializable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = Set(storedValue.map { Element(storedValue: $0) })
    }
}

/// :nodoc:
extension Dictionary: UserDefaultsSerializable where Key == String, Value: UserDefaultsSerializable {
    public var storedValue: [String: Value.StoredValue] {
        self.mapValues { $0.storedValue }
    }

    public init(storedValue: [String: Value.StoredValue]) {
        self = storedValue.mapValues { Value(storedValue: $0) }
    }
}

/// :nodoc:
extension UserDefaultsSerializable where Self: RawRepresentable {
    public var storedValue: RawValue { self.rawValue }

    public init(storedValue: RawValue) {
        self = Self(rawValue: storedValue)!
    }
}