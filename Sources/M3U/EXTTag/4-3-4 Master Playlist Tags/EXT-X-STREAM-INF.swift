//
//  EXT-X-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

/// EXT-X-STREAM-INF
///
/// The EXT-X-STREAM-INF tag specifies a Variant Stream, which is a set
/// of Renditions that can be combined to play the presentation.  The
/// attributes of the tag provide information about the Variant Stream.
///
/// The URI line that follows the EXT-X-STREAM-INF tag specifies a Media
/// Playlist that carries a Rendition of the Variant Stream.  The URI
/// line is REQUIRED.  Clients that do not support multiple video
/// Renditions SHOULD play this Rendition.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2

public struct EXT_X_STREAM_INF: Equatable, EXTPropertyTag {
    
    var properties: OrderedDictionary<PropertyKey, EXTPropertyValue>
    var uri: String
    
    init(properties: OrderedDictionary<PropertyKey, EXTPropertyValue>, uri: String) {
        self.properties = properties
        self.uri = uri
    }
}

extension EXT_X_STREAM_INF {
    
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
    
    public var frameRate: Decimal? {
        get { properties[.frameRate]?.load() }
        set { properties[.frameRate] = newValue.flatMap { .init(decimal: $0) } }
    }
    
    public var closedCaptions: String? {
        get { properties[.closedCaptions]?.load() }
        set { properties[.closedCaptions] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var audio: String? {
        get { properties[.audio]?.load() }
        set { properties[.audio] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var subtitles: String? {
        get { properties[.subtitles]?.load() }
        set { properties[.subtitles] = newValue.flatMap { .init(string: $0) } }
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
        
        static let averageBandwidth = PropertyKey(rawValue: "AVERAGE-BANDWIDTH")
        static let bandwidth        = PropertyKey(rawValue: "BANDWIDTH")
        static let codecs           = PropertyKey(rawValue: "CODECS")
        static let resolution       = PropertyKey(rawValue: "RESOLUTION")
        static let frameRate        = PropertyKey(rawValue: "FRAME-RATE")
        static let closedCaptions   = PropertyKey(rawValue: "CLOSED-CAPTIONS")
        static let audio            = PropertyKey(rawValue: "AUDIO")
        static let subtitles        = PropertyKey(rawValue: "SUBTITLES")
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
