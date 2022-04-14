//
//  EXT-X-MEDIA.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

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

public struct EXT_X_MEDIA: Equatable, EXTAttributesTag {
    
    var attributes: EXTAttributeList
    
    init(attributes: EXTAttributeList) {
        self.attributes = attributes
    }
}
 
extension EXT_X_MEDIA {
     
    public var type: ContentType? {
        get { attributes[.type]?.load() }
        set { attributes[.type] = newValue.flatMap { .init(content: $0) } }
    }
    
    public var groupID: String? {
        get { attributes[.groupID]?.load() }
        set { attributes[.groupID] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var language: String? {
        get { attributes[.language]?.load() }
        set { attributes[.language] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var name: String? {
        get { attributes[.name]?.load() }
        set { attributes[.name] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var `default`: Bool? {
        get { attributes[.default]?.load() }
        set { attributes[.default] = newValue.flatMap { .init(bool: $0) } }
    }
    
    public var autoselect: Bool? {
        get { attributes[.autoselect]?.load() }
        set { attributes[.autoselect] = newValue.flatMap { .init(bool: $0) } }
    }
    
    public var instreamID: String? {
        get { attributes[.instreamID]?.load() }
        set { attributes[.instreamID] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var channels: String? {
        get { attributes[.channels]?.load() }
        set { attributes[.channels] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var uri: String? {
        get { attributes[.uri]?.load() }
        set { attributes[.uri] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var forced: Bool? {
        get { attributes[.forced]?.load() }
        set { attributes[.forced] = newValue.flatMap { .init(bool: $0) } }
    }
}

extension EXT_X_MEDIA {
    
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
        self.init(attributes: EXTTagUtil.decodeKeyValues(plainText: plainText))
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagUtil.encodeKeyValues(attributes: attributes)]
    }
}

extension EXT_X_MEDIA: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-MEDIA(\(attributes))"
    }
}
