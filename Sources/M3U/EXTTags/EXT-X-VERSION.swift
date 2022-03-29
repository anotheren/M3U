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
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        guard let version = Int(plainText) else {
            return nil
        }
        self.init(version: version)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(version)"]
    }
}

extension EXT_X_VERSION: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-VERSION(version:\(version))"
    }
}
