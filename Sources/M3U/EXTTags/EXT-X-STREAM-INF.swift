//
//  EXT-X-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

public struct EXT_X_STREAM_INF: Equatable, EXTPropertyTag {
    
    var properties: OrderedDictionary<PropertyKey, EXTPropertyValue>
    var uri: String
    
    init(properties: OrderedDictionary<PropertyKey, EXTPropertyValue>, uri: String) {
        self.properties = properties
        self.uri = uri
    }
}

extension EXT_X_STREAM_INF {
    
    struct PropertyKey: RawRepresentable, Hashable, CustomStringConvertible {
        
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        var description: String {
            rawValue
        }
    }
}

extension EXT_X_STREAM_INF: EXTTag {
    
    public static var hint: String {
        "#EXT-X-STREAM-INF"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        guard lines.count == 2 else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        let uri = lines[1]
        self.init(properties: EXTTagBuilder.decodeKeyValues(plainText: plainText), uri: uri)
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagBuilder.encodeKeyValues(properties: properties), uri]
    }
}

extension EXT_X_STREAM_INF: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-STREAM-INF(\(properties), \(uri))"
    }
}
