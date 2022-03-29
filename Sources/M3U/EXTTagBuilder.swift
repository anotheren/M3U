//
//  EXTTagBuilder.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

struct EXTTagBuilder {
    
    static func parser(lines: [String]) -> EXTTag? {
        guard lines.count >= 1 else { return nil }
        guard let hint = lines[0].split(separator: ":").first else { return nil }
        switch hint {
        case EXTM3U.hint:
            return EXTM3U(lines: lines)
        case EXT_X_VERSION.hint:
            return EXT_X_VERSION(lines: lines)
        case EXT_X_INDEPENDENT_SEGMENTS.hint:
            return EXT_X_INDEPENDENT_SEGMENTS(lines: lines)
        case EXT_X_MEDIA.hint:
            return EXT_X_MEDIA(lines: lines)
        case EXT_X_I_FRAME_STREAM_INF.hint:
            return EXT_X_I_FRAME_STREAM_INF(lines: lines)
        case EXT_X_STREAM_INF.hint:
            return EXT_X_STREAM_INF(lines: lines)
        default:
            return nil
        }
    }
}

extension EXTTagBuilder {
    
    static func decodeKeyValues<PropertyKey>(plainText: String) -> OrderedDictionary<PropertyKey, EXTPropertyValue> where PropertyKey: RawRepresentable, PropertyKey: Hashable, PropertyKey.RawValue == String {
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
        
        let keyValues: [(PropertyKey, EXTPropertyValue)] = checkedItems.compactMap { item in
            let keyValue = item.split(separator: "=")
            guard keyValue.count == 2 else { return nil }
            let key = String(keyValue[0])
            let value = String(keyValue[1])
            guard let propertyKey = PropertyKey(rawValue: key) else { return nil }
            return (propertyKey, EXTPropertyValue(value))
        }
        
        return OrderedDictionary(uniqueKeysWithValues: keyValues)
    }
    
    static func encodeKeyValues<PropertyKey>(properties: OrderedDictionary<PropertyKey, EXTPropertyValue>) -> String where PropertyKey: RawRepresentable, PropertyKey: Hashable, PropertyKey.RawValue == String {
        return properties
            .map { "\($0.key.rawValue)=\($0.value.value)"}
            .joined(separator: ",")
    }
}
