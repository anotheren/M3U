//
//  EXT-X-VERSION.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-VERSION
///
/// About the EXT-X-VERSION tag
/// https://developer.apple.com/documentation/http_live_streaming/about_the_ext-x-version_tag
///
public struct EXT_X_VERSION: Equatable {
    
    public var version: Int
    
    public init(version: Int) {
        self.version = version
    }
}

extension EXT_X_VERSION: EXTTag {
    
    public static var hint: String {
        "#EXT-X-VERSION"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(EXT_X_VERSION.hint) else {
            return nil
        }
        let versionText = lines[0].replacingOccurrences(of: "\(EXT_X_VERSION.hint):", with: "")
        guard let version = Int(versionText) else {
            return nil
        }
        self.init(version: version)
    }
    
    public var lines: [String] {
        ["\(EXT_X_VERSION.hint):\(version)"]
    }
}
