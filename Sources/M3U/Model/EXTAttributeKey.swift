//
//  EXTAttributeKey.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/21.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTAttributeKey: RawRepresentable, Hashable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension EXTAttributeKey: CustomStringConvertible {
    
    public var description: String {
        rawValue
    }
}

extension EXTAttributeKey {
    
    public static let type              = EXTAttributeKey(rawValue: "TYPE")
    public static let groupID           = EXTAttributeKey(rawValue: "GROUP-ID")
    public static let language          = EXTAttributeKey(rawValue: "LANGUAGE")
    public static let name              = EXTAttributeKey(rawValue: "NAME")
    public static let `default`         = EXTAttributeKey(rawValue: "DEFAULT")
    public static let autoselect        = EXTAttributeKey(rawValue: "AUTOSELECT")
    public static let instreamID        = EXTAttributeKey(rawValue: "INSTREAM-ID")
    public static let channels          = EXTAttributeKey(rawValue: "CHANNELS")
    public static let uri               = EXTAttributeKey(rawValue: "URI")
    public static let forced            = EXTAttributeKey(rawValue: "FORCED")
    public static let averageBandwidth  = EXTAttributeKey(rawValue: "AVERAGE-BANDWIDTH")
    public static let bandwidth         = EXTAttributeKey(rawValue: "BANDWIDTH")
    public static let codecs            = EXTAttributeKey(rawValue: "CODECS")
    public static let resolution        = EXTAttributeKey(rawValue: "RESOLUTION")
    public static let frameRate         = EXTAttributeKey(rawValue: "FRAME-RATE")
    public static let closedCaptions    = EXTAttributeKey(rawValue: "CLOSED-CAPTIONS")
    public static let audio             = EXTAttributeKey(rawValue: "AUDIO")
    public static let subtitles         = EXTAttributeKey(rawValue: "SUBTITLES")
    public static let byterange         = EXTAttributeKey(rawValue: "BYTERANGE")
    public static let method            = EXTAttributeKey(rawValue: "METHOD")
    public static let iv                = EXTAttributeKey(rawValue: "IV")
}
