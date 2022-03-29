//
//  EXT-X-I-FRAME-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/29.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

public struct EXT_X_I_FRAME_STREAM_INF: Equatable, EXTPropertyTag {
    
    var properties: OrderedDictionary<PropertyKey, EXTPropertyValue>
    
    init(keyValues: [(PropertyKey, EXTPropertyValue)]) {
        let properties = OrderedDictionary(uniqueKeysWithValues: keyValues)
        self.properties = properties
    }
}

extension EXT_X_I_FRAME_STREAM_INF {
    
    public var averageBandwidth: Int? {
        get { properties[.averageBandwidth]?.load() }
        set { properties[.averageBandwidth] = newValue.flatMap { .init(int: $0) } }
    }
    
    public var bandwidth: Int? {
        get { properties[.bandwidth]?.load() }
        set { properties[.bandwidth] = newValue.flatMap { .init(int: $0) } }
    }
    
    public var codecs: String? {
        get { properties[.codecs]?.load() }
        set { properties[.codecs] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var resolution: EXTResolution? {
        get { properties[.resolution]?.load() }
        set { properties[.resolution] = newValue.flatMap { .init(resolution: $0) } }
    }
    
    public var uri: String? {
        get { properties[.uri]?.load() }
        set { properties[.uri] = newValue.flatMap { .init(string: $0) } }
    }
}

extension EXT_X_I_FRAME_STREAM_INF {
    
    struct PropertyKey: RawRepresentable, Hashable, CustomStringConvertible {
        
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        var description: String {
            rawValue
        }
        
        static let averageBandwidth = PropertyKey(rawValue: "AVERAGE-BANDWIDTH")
        static let bandwidth        = PropertyKey(rawValue: "BANDWIDTH")
        static let codecs           = PropertyKey(rawValue: "CODECS")
        static let resolution       = PropertyKey(rawValue: "RESOLUTION")
        static let uri              = PropertyKey(rawValue: "URI")
    }
}

extension EXT_X_I_FRAME_STREAM_INF: EXTTag {
    
    public static var hint: String {
        "#EXT-X-I-FRAME-STREAM-INF"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(Self.hint) else {
            return nil
        }
        let items = lines[0].replacingOccurrences(of: "\(Self.hint):", with: "").split(separator: ",")
        let keyValues: [(PropertyKey, EXTPropertyValue)] = items.compactMap { item in
            let keyValue = item.split(separator: "=")
            guard keyValue.count == 2 else { return nil }
            let key = String(keyValue[0])
            let value = String(keyValue[1])
            return (PropertyKey(rawValue: key), EXTPropertyValue(value))
        }
        self.init(keyValues: keyValues)
    }
    
    public var lines: [String] {
        let items = properties.map { "\($0.key.rawValue)=\($0.value.value)"}
        let description = Self.hint + ":" + items.joined(separator: ",")
        return [description]
    }
}

extension EXT_X_I_FRAME_STREAM_INF: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-I-FRAME-STREAM-INF(\(properties))"
    }
}
