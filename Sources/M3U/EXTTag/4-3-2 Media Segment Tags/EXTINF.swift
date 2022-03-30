//
//  EXTINF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTINF: Equatable {
    
    public var duration: Decimal
    public var uri: String
    public var associatedTag: AssociatedTag?
    
    public init(duration: Decimal, uri: String, associatedTag: AssociatedTag? = nil) {
        self.duration = duration
        self.uri = uri
        self.associatedTag = associatedTag
    }
}

extension EXTINF {
    
    public enum AssociatedTag: RawRepresentable, Equatable {
        
        case byteRange(EXT_X_BYTERANGE)
        case bitRate(EXT_X_BITRATE)
        
        public init?(rawValue: EXTTag) {
            switch rawValue {
            case let rawValue as EXT_X_BYTERANGE:
                self = .byteRange(rawValue)
            case let rawValue as EXT_X_BITRATE:
                self = .bitRate(rawValue)
            default:
                return nil
            }
        }
        
        public var rawValue: EXTTag {
            switch self {
            case .byteRange(let tag): return tag
            case .bitRate(let tag): return tag
            }
        }
        
        public var byteRange: EXT_X_BYTERANGE? {
            switch self {
            case .byteRange(let tag): return tag
            default: return nil
            }
        }
        
        public var bitRate: EXT_X_BITRATE? {
            switch self {
            case .bitRate(let tag): return tag
            default: return nil
            }
        }
    }
}

extension EXTINF: EXTTag {
    
    public static var hint: String {
        "#EXTINF"
    }
    
    public init?(lines: [String]) {
        let line0 = lines[0]
        guard line0.hasPrefix(Self.hint), lines.count >= 2 else {
            return nil
        }
        let hasAssociatedTag = line0.hasSuffix("\t")
        let startIndex = line0.index(line0.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = hasAssociatedTag ? line0.index(line0.endIndex, offsetBy: -1) : line0.endIndex
        let plainText = line0[startIndex..<endIndex]
        guard let value = plainText.split(separator: ",").first, let duration = Decimal(string: String(value)) else {
            return nil
        }
        guard let uri = lines.last, !uri.hasPrefix("#") else {
            return nil
        }
        var associatedTag: AssociatedTag?
        if lines.count-1 > 1, hasAssociatedTag, let tag = EXTTagBuilder.parser(lines: Array(lines[1..<lines.count-1])) {
            associatedTag = AssociatedTag(rawValue: tag)
        }
        self.init(duration: duration, uri: uri, associatedTag: associatedTag)
    }
    
    public var lines: [String] {
        var lines = [String]()
        lines.append("\(Self.hint):\(duration),")
        if let tag = associatedTag?.rawValue {
            lines[0].append("\t")
            lines.append(contentsOf: tag.lines)
        }
        lines.append(uri)
        return lines
    }
}

extension EXTINF: CustomStringConvertible {
    
    public var description: String {
        var description = "EXTINF(duration:\(duration)"
        if let byteRange = associatedTag?.byteRange {
            description.append(contentsOf: ",byteRange:\(byteRange.range)")
        }
        if let bitRate = associatedTag?.bitRate {
            description.append(contentsOf: ",bitRate:\(bitRate.rate)")
        }
        description.append(contentsOf: ",uri:\(uri))")
        return description
    }
}
