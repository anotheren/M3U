//
//  EXT-X-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

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

public struct EXT_X_STREAM_INF: Equatable, EXTAttributesTag {
    
    var attributes: EXTAttributeList
    var uri: String
    
    init(attributes: EXTAttributeList, uri: String) {
        self.attributes = attributes
        self.uri = uri
    }
}

extension EXT_X_STREAM_INF {
    
    public var averageBandwidth: Int? {
        get { attributes[.averageBandwidth]?.load() }
        set { attributes[.averageBandwidth] = newValue.flatMap { .init(int: $0) } }
    }
    
    public var bandwidth: Int? {
        get { attributes[.bandwidth]?.load() }
        set { attributes[.bandwidth] = newValue.flatMap { .init(int: $0) } }
    }
    
    public var codecs: String? {
        get { attributes[.codecs]?.load() }
        set { attributes[.codecs] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var resolution: EXTResolution? {
        get { attributes[.resolution]?.load() }
        set { attributes[.resolution] = newValue.flatMap { .init(resolution: $0) } }
    }
    
    public var frameRate: Double? {
        get { attributes[.frameRate]?.load() }
        set { attributes[.frameRate] = newValue.flatMap { .init(double: $0, fractionDigits: 3) } }
    }
    
    public var closedCaptions: String? {
        get { attributes[.closedCaptions]?.load() }
        set { attributes[.closedCaptions] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var audio: String? {
        get { attributes[.audio]?.load() }
        set { attributes[.audio] = newValue.flatMap { .init(string: $0) } }
    }
    
    public var subtitles: String? {
        get { attributes[.subtitles]?.load() }
        set { attributes[.subtitles] = newValue.flatMap { .init(string: $0) } }
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
        self.init(attributes: EXTTagUtil.decodeKeyValues(plainText: plainText), uri: uri)
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagUtil.encodeKeyValues(attributes: attributes), uri]
    }
}

extension EXT_X_STREAM_INF: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-STREAM-INF(\(attributes), \(uri))"
    }
}
