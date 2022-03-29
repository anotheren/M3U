//
//  EXT-X-MEDIA.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

public struct EXT_X_MEDIA: Equatable, EXTPropertyTag {
    
    var properties: OrderedDictionary<PropertyKey, EXTPropertyValue>
    
    init(keyValues: [(PropertyKey, EXTPropertyValue)]) {
        let properties = OrderedDictionary(uniqueKeysWithValues: keyValues)
        self.properties = properties
    }
}
 
extension EXT_X_MEDIA {
     
    public var type: ContentType? {
        get { properties[.type]?.load() }
        set { properties[.type] = newValue.flatMap { .init(content: $0) } }
    }
    
    public var groupID: String? {
        get { properties[.groupID]?.load() }
        set { properties[.groupID] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var language: String? {
        get { properties[.language]?.load() }
        set { properties[.language] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var name: String? {
        get { properties[.name]?.load() }
        set { properties[.name] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var `default`: Bool? {
        get { properties[.default]?.load() }
        set { properties[.default] = newValue.flatMap { .init(bool: $0) } }
    }
    
    public var autoselect: Bool? {
        get { properties[.autoselect]?.load() }
        set { properties[.autoselect] = newValue.flatMap { .init(bool: $0) } }
    }
    
    public var instreamID: String? {
        get { properties[.instreamID]?.load() }
        set { properties[.instreamID] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var channels: String? {
        get { properties[.channels]?.load() }
        set { properties[.channels] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var uri: String? {
        get { properties[.uri]?.load() }
        set { properties[.uri] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var forced: Bool? {
        get { properties[.forced]?.load() }
        set { properties[.forced] = newValue.flatMap { .init(bool: $0) } }
    }
}

extension EXT_X_MEDIA {
    
    struct PropertyKey: RawRepresentable, Hashable, CustomStringConvertible {
        
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        var description: String {
            rawValue
        }
        
        static let type =        PropertyKey(rawValue: "TYPE")
        static let groupID =     PropertyKey(rawValue: "GROUP-ID")
        static let language =    PropertyKey(rawValue: "LANGUAGE")
        static let name =        PropertyKey(rawValue: "NAME")
        static let `default` =   PropertyKey(rawValue: "DEFAULT")
        static let autoselect =  PropertyKey(rawValue: "AUTOSELECT")
        static let instreamID =  PropertyKey(rawValue: "INSTREAM-ID")
        static let channels =    PropertyKey(rawValue: "CHANNELS")
        static let uri =         PropertyKey(rawValue: "URI")
        static let forced =      PropertyKey(rawValue: "FORCED")
    }
    
    public struct ContentType: RawRepresentable, Equatable, CustomStringConvertible {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public var description: String {
            rawValue
        }
        
        public static let audio = ContentType(rawValue: "AUDIO")
        public static let closedCaption = ContentType(rawValue: "CLOSED-CAPTION")
        public static let subtitles = ContentType(rawValue: "SUBTITLES")
    }
}

extension EXT_X_MEDIA: EXTTag {
    
    public static var hint: String {
        "#EXT-X-MEDIA"
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

extension EXT_X_MEDIA: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-MEDIA(\(properties))"
    }
}
