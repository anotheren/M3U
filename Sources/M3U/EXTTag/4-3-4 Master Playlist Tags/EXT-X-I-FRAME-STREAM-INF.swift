//
//  EXT-X-I-FRAME-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/29.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-I-FRAME-STREAM-INF
///
/// The EXT-X-I-FRAME-STREAM-INF tag identifies a Media Playlist file
/// containing the I-frames of a multimedia presentation.  It stands
/// alone, in that it does not apply to a particular URI in the Master
/// Playlist.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.3

public struct EXT_X_I_FRAME_STREAM_INF: Equatable, EXTAttributesTag {
    
    var attributes: EXTAttributeList
    
    init(attributes: EXTAttributeList) {
        self.attributes = attributes
    }
}

extension EXT_X_I_FRAME_STREAM_INF {
    
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
    
    public var uri: String? {
        get { attributes[.uri]?.load() }
        set { attributes[.uri] = newValue.flatMap { .init(string: $0) } }
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
        self.init(attributes: EXTTagUtil.decodeKeyValues(plainText: plainText))
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagUtil.encodeKeyValues(properties: attributes)]
    }
}

extension EXT_X_I_FRAME_STREAM_INF: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-I-FRAME-STREAM-INF(\(attributes))"
    }
}
