//
//  EXTAttributeValue.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/26.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTAttributeValue: Equatable {
    
    public var value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

extension EXTAttributeValue: CustomStringConvertible {
    
    public var description: String {
        value
    }
}

// MARK: String
extension EXTAttributeValue {
    
    func load() -> String? {
        guard value.hasPrefix("\""), value.hasSuffix("\""), value.count >= 2 else {
            return nil
        }
        let startIndex = value.index(value.startIndex, offsetBy: 1)
        let endIndex = value.index(value.endIndex, offsetBy: -1)
        return String(value[startIndex..<endIndex])
    }
    
    init(string: String) {
        self.init("\"\(string)\"")
    }
}

// MARK: Bool
extension EXTAttributeValue {
    
    func load() -> Bool? {
        switch value {
        case "YES":
            return true
        case "NO":
            return false
        default:
            return nil
        }
    }
    
    init(bool: Bool) {
        self.init(bool ? "YES" : "NO")
    }
}

// MARK: Int
extension EXTAttributeValue {
    
    func load() -> Int? {
        guard let int = Int(value) else {
            return nil
        }
        return int
    }
    
    init(int: Int) {
        self.init("\(int)")
    }
}

// MARK: Double
extension EXTAttributeValue {
    
    func load() -> Double? {
        guard let double = Double(value) else {
            return nil
        }
        return double
    }
    
    init?(double: Double, fractionDigits: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
        guard let value = formatter.string(from: NSNumber(value: double)) else {
            return nil
        }
        self.init(value)
    }
}

// MARK: Resolution
extension EXTAttributeValue {
    
    func load() -> EXTResolution? {
        EXTResolution(string: value)
    }
    
    init(resolution: EXTResolution) {
        self.init("\(resolution)")
    }
}

extension EXTAttributeValue {
    
    func load<Content: RawRepresentable>() -> Content? where Content.RawValue == String {
        guard let content = Content(rawValue: value) else {
            return nil
        }
        return content
    }
    
    init<Content: RawRepresentable>(content: Content) where Content.RawValue == String {
        self.init(content.rawValue)
    }
}
