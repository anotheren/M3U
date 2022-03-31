//
//  EXTTagUtil.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

struct EXTTagUtil {
    
    static func parser(lines: [String]) -> EXTTag? {
        guard !lines.isEmpty else { return nil }
        guard let hint = lines[0].split(separator: ":").first else { return nil }
        switch hint {
        
        /// 4.3.1.1 EXTM3U
        case EXTM3U.hint:
            return EXTM3U(lines: lines)
            
        /// 4.3.1.2 EXT-X-VERSION
        case EXT_X_VERSION.hint:
            return EXT_X_VERSION(lines: lines)
        
        /// 4.3.2.1 EXTINF
        case EXTINF.hint:
            return EXTINF(lines: lines)
            
        /// ???? EXT-X-BITRATE
        case EXT_X_BITRATE.hint:
            return EXT_X_BITRATE(lines: lines)
            
        /// 4.3.2.2 EXT-X-BYTERANGE
        case EXT_X_BYTERANGE.hint:
            return EXT_X_BYTERANGE(lines: lines)
        
        /// 4.3.3.1 EXT-X-TARGETDURATION
        case EXT_X_TARGETDURATION.hint:
            return EXT_X_TARGETDURATION(lines: lines)
            
        /// 4.3.3.2 EXT-X-MEDIA-SEQUENCE
        case EXT_X_MEDIA_SEQUENCE.hint:
            return EXT_X_MEDIA_SEQUENCE(lines: lines)
            
        /// 4.3.3.4 EXT-X-ENDLIST
        case EXT_X_ENDLIST.hint:
            return EXT_X_ENDLIST(lines: lines)
            
        /// 4.3.3.5 EXT-X-PLAYLIST-TYPE
        case EXT_X_PLAYLIST_TYPE.hint:
            return EXT_X_PLAYLIST_TYPE(lines: lines)
         
        /// 4.3.4.1 EXT-X-MEDIA
        case EXT_X_MEDIA.hint:
            return EXT_X_MEDIA(lines: lines)
            
        /// 4.3.4.2 EXT-X-STREAM-INF
        case EXT_X_STREAM_INF.hint:
            return EXT_X_STREAM_INF(lines: lines)
            
        /// 4.3.4.3 EXT-X-I-FRAME-STREAM-INF
        case EXT_X_I_FRAME_STREAM_INF.hint:
            return EXT_X_I_FRAME_STREAM_INF(lines: lines)
        
        /// 4.3.5.1 EXT-X-INDEPENDENT-SEGMENTS
        case EXT_X_INDEPENDENT_SEGMENTS.hint:
            return EXT_X_INDEPENDENT_SEGMENTS(lines: lines)
        
        default:
            return nil
        }
    }
}

extension EXTTagUtil {
    
    static func decodeKeyValues(plainText: String) -> EXTAttributeList {
        let items = plainText.split(separator: ",")
        
        var checkedItems = [String.SubSequence]()
        for item in items {
            if item.contains("=") {
                checkedItems.append(item)
            } else if !checkedItems.isEmpty {
                var last = checkedItems.removeLast()
                last.append(",")
                last.append(contentsOf: item)
                checkedItems.append(last)
            }
        }
        
        let keyValues: [(EXTAttributeKey, EXTAttributeValue)] = checkedItems.compactMap { item in
            let keyValue = item.split(separator: "=")
            guard keyValue.count == 2 else { return nil }
            let key = String(keyValue[0])
            let value = String(keyValue[1])
            return (EXTAttributeKey(rawValue: key), EXTAttributeValue(value))
        }
        
        return EXTAttributeList(uniqueKeysWithValues: keyValues)
    }
    
    static func encodeKeyValues(properties: EXTAttributeList) -> String {
        return properties
            .map { "\($0.key.rawValue)=\($0.value.value)"}
            .joined(separator: ",")
    }
}
