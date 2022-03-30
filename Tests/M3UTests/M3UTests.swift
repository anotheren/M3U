import XCTest
import Alamofire
@testable import M3U

/// Apple HLS Examples
/// https://developer.apple.com/streaming/examples/
private enum AppleHLSTestURL: String, CaseIterable {
    
    /// Advanced stream - TS
    /// TS stream compatible with macOS v10.7 or later, iOS 6 or later, and tvOS 9 or later
    case advancedStream_TS = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
    
    /// Advanced stream - fMP4
    /// fMP4 stream compatible with macOS v10.12 or later, iOS 10 or later, and tvOS 10 or later
    case advancedStream_fMP4 = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
    
    /// Advanced stream (HEVC/H.264)
    /// Stream backwards compatible with macOS v10.7 or later, iOS 6 or later, and tvOS 9 or later
    /// HEVC variants compatible with macOS v10.13 or later, iOS 11 or later, and tvOS 11 or later
    case advancedStream_HEVC = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"
    
    var url: URL { URL(string: rawValue)! }
}

final class M3UTests: XCTestCase {
    
    func testAppleHLS_advancedStream_TS() async throws {
        let masterURL = AppleHLSTestURL.advancedStream_TS.url
        let masterPlayList = try await loadM3U(url: masterURL)
        
        if let stream_inf = masterPlayList.tags.compactMap({ $0 as? EXT_X_STREAM_INF }).randomElement() {
            let url = masterURL.deletingLastPathComponent().appendingPathComponent(stream_inf.uri)
            try await loadM3U(url: url)
        }
        
        if let audio = masterPlayList.tags.compactMap({ $0 as? EXT_X_MEDIA }).filter({ $0.type == .audio }).randomElement(), let uri = audio.uri {
            let url = masterURL.deletingLastPathComponent().appendingPathComponent(uri)
            try await loadM3U(url: url)
        }
    }
    
    func testAppleHLS_advancedStream_fMP4() async throws {
        let masterURL = AppleHLSTestURL.advancedStream_fMP4.url
        let masterPlayList = try await loadM3U(url: masterURL)
        
        if let stream_inf = masterPlayList.tags.compactMap({ $0 as? EXT_X_STREAM_INF }).randomElement() {
            let url = masterURL.deletingLastPathComponent().appendingPathComponent(stream_inf.uri)
            try await loadM3U(url: url)
        }
    }
}

extension M3UTests {
    
    @discardableResult
    private func loadM3U(url: URL) async throws -> M3U {
        print("➡️ Load URL:\(url)")
        let request = AF.request(url)
        let dataTask = request.serializingData()
        let data = try await dataTask.value
        let plainText = String(data: data, encoding: .utf8)!
        let m3u = M3U(string: plainText)!
        let newPlainText = m3u.string
        XCTAssertTrue(plainText == newPlainText, "⚠️\n\(plainText)\n⚠️\(newPlainText)\n")
        print("➡️ Tags for M3U")
        print(m3u)
        return m3u
    }
}
