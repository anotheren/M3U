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
    
    public init?(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(plainText: string)
    }
    
    public init?(plainText: String) {
        guard !plainText.isEmpty else { return nil }
        
        var tags = [EXTTag]()
        let lines = plainText.split(separator: "\n", omittingEmptySubsequences: false)
        for (index, line) in lines.enumerated() {
            if line.isEmpty {
                tags.append(EXT_BLANK_LINE())
            } else if line.hasPrefix("#") {
                let hasNextLine = index < lines.count-1
                if hasNextLine, !lines[index+1].isEmpty, !lines[index+1].hasPrefix("#") {
                    // tag with TWO lines
                    let lines = [String(line), String(lines[index+1])]
                    let tag = EXTTagBuilder.parser(lines: lines) ?? EXT_UNKNOWN(lines: lines)
                    tags.append(tag)
                } else {
                    // tag with only ONE line
                    let lines = [String(line)]
                    let tag = EXTTagBuilder.parser(lines: lines) ?? EXT_UNKNOWN(lines: lines)
                    tags.append(tag)
                }
            }
        }
        self.init(tags: tags)
    }
}

extension M3U {
    
    public var lines: [String] {
        var lines = [String]()
        for tag in tags {
            lines.append(contentsOf: tag.lines)
        }
        return lines
    }
    
    public var plainText: String {
        return lines.joined(separator: "\n")
    }
}

extension M3U: CustomStringConvertible {
    
    public var description: String {
        return tags
            .map { $0.description }
            .joined(separator: "\n")
    }
}