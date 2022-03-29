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
        self.init(string: string)
    }
    
    public init?(string: String) {
        guard !string.isEmpty else { return nil }
        
        var tags = [EXTTag]()
        let lines = string.split(separator: "\n", omittingEmptySubsequences: false)
        for (index, line) in lines.enumerated() {
            if line.isEmpty {
                tags.append(EXT_BLANK_LINE())
            } else if line.hasPrefix("#") {
                let hasNextLine = index < lines.count-1
                if hasNextLine, !lines[index+1].hasPrefix("#") {
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
