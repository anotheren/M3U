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
    
    init(properties: OrderedDictionary<PropertyKey, EXTPropertyValue>) {
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
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        self.init(properties: EXTTagBuilder.decodeKeyValues(plainText: plainText))
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagBuilder.encodeKeyValues(properties: properties)]
    }
}

extension EXT_X_I_FRAME_STREAM_INF: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-I-FRAME-STREAM-INF(\(properties))"
    }
}
