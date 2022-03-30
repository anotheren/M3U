//
//  EXTPropertyValue.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/26.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

struct EXTPropertyValue: Equatable {
    
    var value: String
    
    init(_ value: String) {
        self.value = value
    }
}

extension EXTPropertyValue: CustomStringConvertible {
    
    var description: String {
        value
    }
}

// MARK: String
extension EXTPropertyValue {
    
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
extension EXTPropertyValue {
    
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
extension EXTPropertyValue {
    
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
extension EXTPropertyValue {
    
    func load() -> Double? {
        guard let double = Double(value) else {
            return nil
        }
        return double
    }
    
    init(double: Double) {
        self.init(String(format: "%0.3f", arguments: [double]))
    }
}

// MARK: Resolution
extension EXTPropertyValue {
    
    func load() -> EXTResolution? {
        let items = value.split(separator: "x")
        guard items.count == 2, let width = Int(items[0]), let height = Int(items[1]) else {
            return nil
        }
        return EXTResolution(width: width, height: height)
    }
    
    init(resolution: EXTResolution) {
        self.init("\(resolution.width)x\(resolution.height)")
    }
}

extension EXTPropertyValue {
    
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