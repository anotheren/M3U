//
//  EXTTagBuilder.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

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
        default:
            return nil
        }
    }
}
