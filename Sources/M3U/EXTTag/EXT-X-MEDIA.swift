//
//  EXT-X-MEDIA.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_MEDIA {
    
    public var type: ContentType
    public var groupID: String
    public var name: String
    public var language: String
//    public va
    
}

extension EXT_X_MEDIA {
    
    public enum ContentType: String {
        case audio = "AUDIO"
        case closedCaption = "CLOSED-CAPTION"
        case subtitles = "SUBTITLES"
    }
}

extension EXT_X_MEDIA: EXTTag {
    
    public static var hint: String {
        "#EXT_X_MEDIA"
    }
    
    public init?(content: String) {
        guard content.hasPrefix(EXT_X_MEDIA.hint) else {
            return nil
        }
        fatalError()
    }
    
    public var content: String {
        var description = EXT_X_MEDIA.hint + ":"
        
        return description
    }
}
