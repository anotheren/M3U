//
//  EXT-X-MAP.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/31.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-MAP
///
/// The EXT-X-MAP tag specifies how to obtain the Media Initialization
/// Section (Section 3) required to parse the applicable Media Segments.
/// It applies to every Media Segment that appears after it in the
/// Playlist until the next EXT-X-MAP tag or until the end of the
/// Playlist.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.5
///
public struct EXT_X_MAP: Equatable, EXTAttributesTag {
    
    var attributes: EXTAttributeList
    
    init(properties: EXTAttributeList) {
        self.attributes = properties
    }
}

extension EXT_X_MAP {
    
    /// URI
    ///
    /// The value is a quoted-string containing a URI that identifies a
    /// resource that contains the Media Initialization Section.  This
    /// attribute is REQUIRED.
    ///
    public var uri: String? {
        get { attributes[.uri]?.load() }
        set { attributes[.uri] = newValue.flatMap { .init(string: $0) } }
    }
    
    /// BYTERANGE
    ///
    /// The value is a quoted-string specifying a byte range into the
    /// resource identified by the URI attribute.  This range SHOULD
    /// contain only the Media Initialization Section.  The format of the
    /// byte range is described in Section 4.3.2.2.  This attribute is
    /// OPTIONAL; if it is not present, the byte range is the entire
    /// resource indicated by the URI.
    ///
    public var byterange: EXTByterange? {
        get {
            let string: String? = attributes[.byterange]?.load()
            return string.flatMap { EXTByterange(string: $0) }
        }
        set {
            attributes[.byterange] = newValue
                .flatMap { $0.description }
                .flatMap { EXTAttributeValue(string: $0) }
        }
    }
}

extension EXT_X_MAP: EXTTag {
    
    public static var hint: String {
        "#EXT-X-MAP"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        self.init(properties: EXTTagUtil.decodeKeyValues(plainText: plainText))
    }
    
    public var lines: [String] {
        [Self.hint + ":" + EXTTagUtil.encodeKeyValues(properties: attributes)]
    }
}

extension EXT_X_MAP: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-MAP(\(attributes))"
    }
}
