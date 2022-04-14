//
//  EXT-X-KEY.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-KEY
///
/// Media Segments MAY be encrypted.  The EXT-X-KEY tag specifies how to
/// decrypt them.  It applies to every Media Segment and to every Media
/// Initialization Section declared by an EXT-X-MAP tag that appears
/// between it and the next EXT-X-KEY tag in the Playlist file with the
/// same KEYFORMAT attribute (or the end of the Playlist file).  Two or
/// more EXT-X-KEY tags with different KEYFORMAT attributes MAY apply to
/// the same Media Segment if they ultimately produce the same decryption
/// key.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4
///
public struct EXT_X_KEY: Equatable, EXTAttributesTag {
    
    var attributes: EXTAttributeList
    
    init(attributes: EXTAttributeList) {
        self.attributes = attributes
    }
}

extension EXT_X_KEY {
    
    /// METHOD
    ///
    /// The value is an enumerated-string that specifies the encryption
    /// method.  This attribute is REQUIRED.
    ///
    public var method: EncryptionMethod? {
        get { attributes[.method]?.load() }
        set { attributes[.method] = newValue.flatMap { .init(content: $0) } }
    }
    
    /// URI
    ///
    /// The value is a quoted-string containing a URI that specifies how
    /// to obtain the key.  This attribute is REQUIRED unless the METHOD
    /// is NONE.
    ///
    public var uri: String? {
        get { attributes[.uri]?.load() }
        set { attributes[.uri] = newValue.flatMap { .init(string: $0) } }
    }
    
    /// IV
    ///
    /// The value is a hexadecimal-sequence that specifies a 128-bit
    /// unsigned integer Initialization Vector to be used with the key.
    /// Use of the IV attribute REQUIRES a compatibility version number of
    /// 2 or greater.  See Section 5.2 for when the IV attribute is used.
    ///
    public var iv: String? {
        get { attributes[.iv]?.value }
        set { attributes[.iv] = newValue.flatMap { .init($0) } }
    }
}

extension EXT_X_KEY {
    
    public enum EncryptionMethod: String, Equatable {
        
        case none       = "NONE"
        case aes128     = "AES-128"
        case sampleAES  = "SAMPLE-AES"
    }
}

extension EXT_X_KEY: EXTTag {
    
    public static var hint: String {
        "#EXT-X-KEY"
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

extension EXT_X_KEY: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-KEY(\(attributes))"
    }
}
