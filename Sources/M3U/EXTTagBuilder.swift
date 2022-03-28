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
        if lines[0].hasPrefix(EXTM3U.hint) {
            return EXTM3U(lines: lines)
        } else if lines[0].hasPrefix(EXT_X_VERSION.hint) {
            return EXT_X_VERSION(lines: lines)
        } else if lines[0].hasPrefix(EXT_X_INDEPENDENT_SEGMENTS.hint) {
            return EXT_X_INDEPENDENT_SEGMENTS(lines: lines)
        } else if lines[0].hasPrefix(EXT_X_MEDIA.hint) {
            return EXT_X_MEDIA(lines: lines)
        } else {
            return nil
        }
    }
}
