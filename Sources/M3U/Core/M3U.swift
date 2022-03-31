//
//  M3U.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct M3U {

    public var tags: [EXTTag]
    
    public init(tags: [EXTTag]) {
        self.tags = tags
    }
}

extension M3U {
    
    public var data: Data? {
        string.data(using: .utf8)
    }
    
    public init?(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(string: string)
    }
}

extension M3U {
    
    public var string: String {
        return lines.joined(separator: "\n")
    }
    
    public init?(string: String) {
        guard !string.isEmpty else { return nil }
        
        var tags = [EXTTag]()
        var skipIndexs = [Int]()
        let lines = string.split(separator: "\n", omittingEmptySubsequences: false)
        for (index, line) in lines.enumerated() {
            if skipIndexs.contains(index) {
                continue
            } else if line.isEmpty {
                tags.append(EXT_BLANK_LINE())
            } else if line.hasPrefix("#") {
                let hasNextLine = index < lines.count-1
                if line.hasSuffix("\t"), hasNextLine, index < lines.count-2, lines[index+1].hasPrefix("#") {
                    // tag with THREE lines, for example, EXTINF contains EXT-X-BITRATE/EXT-X-BYTERANGE
                    let lines = [String(line), String(lines[index+1]), String(lines[index+2])]
                    let tag = EXTTagUtil.parser(lines: lines) ?? EXT_UNKNOWN(lines: lines)
                    tags.append(tag)
                    skipIndexs.append(contentsOf: [index+1, index+2])
                } else if hasNextLine, !lines[index+1].isEmpty, !lines[index+1].hasPrefix("#") {
                    // tag with TWO lines
                    let lines = [String(line), String(lines[index+1])]
                    let tag = EXTTagUtil.parser(lines: lines) ?? EXT_UNKNOWN(lines: lines)
                    tags.append(tag)
                    skipIndexs.append(index+1)
                } else {
                    // tag with only ONE line
                    let lines = [String(line)]
                    let tag = EXTTagUtil.parser(lines: lines) ?? EXT_UNKNOWN(lines: lines)
                    tags.append(tag)
                }
            }
        }
        self.init(tags: tags)
    }
}

extension M3U {
    
    public var lines: [String] {
        tags.reduce([]) { $0 + $1.lines }
    }
}

extension M3U: CustomStringConvertible {
    
    public var description: String {
        return tags
            .map { $0.description }
            .joined(separator: "\n")
    }
}
