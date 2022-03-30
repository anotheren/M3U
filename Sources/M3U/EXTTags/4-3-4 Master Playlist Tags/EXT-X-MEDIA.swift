//
//  EXT-X-MEDIA.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

/// EXT-X-MEDIA
///
/// The EXT-X-MEDIA tag is used to relate Media Playlists that contain
/// alternative Renditions (Section 4.3.4.2.1) of the same content.  For
/// example, three EXT-X-MEDIA tags can be used to identify audio-only
/// Media Playlists that contain English, French, and Spanish Renditions
/// of the same presentation.  Or, two EXT-X-MEDIA tags can be used to
/// identify video-only Media Playlists that show two different camera
/// angles.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.1
///

public struct EXT_X_MEDIA: Equatable, EXTPropertyTag {
    
    var properties: OrderedDictionary<PropertyKey, EXTPropertyValue>
    
    init(properties: OrderedDictionary<PropertyKey, EXTPropertyValue>) {
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
        
        static let type       = PropertyKey(rawValue: "TYPE")
        static let groupID    = PropertyKey(rawValue: "GROUP-ID")
        static let language   = PropertyKey(rawValue: "LANGUAGE")
        static let name       = PropertyKey(rawValue: "NAME")
        static let `default`  = PropertyKey(rawValue: "DEFAULT")
        static let autoselect = PropertyKey(rawValue: "AUTOSELECT")
        static let instreamID = PropertyKey(rawValue: "INSTREAM-ID")
        static let channels   = PropertyKey(rawValue: "CHANNELS")
        static let uri        = PropertyKey(rawValue: "URI")
        static let forced     = PropertyKey(rawValue: "FORCED")
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

extension EXT_X_MEDIA: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-MEDIA(\(properties))"
    }
}
