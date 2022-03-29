import XCTest
import Alamofire
@testable import M3U

/// Apple HLS Examples
/// https://developer.apple.com/streaming/examples/
private enum AppleHLSTestURL: String, CaseIterable {
    
    /// Advanced stream
    /// fMP4 stream compatible with macOS v10.12 or later, iOS 10 or later, and tvOS 10 or later
    case advancedStream = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
    
    /// Advanced stream (HEVC/H.264)
    /// Stream backwards compatible with macOS v10.7 or later, iOS 6 or later, and tvOS 9 or later
    /// HEVC variants compatible with macOS v10.13 or later, iOS 11 or later, and tvOS 11 or later
    case advancedStreamHEVC = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"
    
    var url: URL { URL(string: rawValue)! }
}

final class M3UTests: XCTestCase {
    
    func testAppleHLSTestURLs() async throws {
        for appleHlS in AppleHLSTestURL.allCases {
            try await test(url: appleHlS.url)
        }
    }
}

extension M3UTests {
    
    private func test(url: URL) async throws {
        let request = AF.request(url)
        let dataTask = request.serializingData()
        let data = try await dataTask.value
        let plainText = String(data: data, encoding: .utf8)!
        let m3u = M3U(plainText: plainText)!
        print(m3u)
        let newPlainText = m3u.plainText
        XCTAssertTrue(plainText == newPlainText)
    }
}
