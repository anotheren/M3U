import XCTest
import Alamofire
@testable import M3U

/// Apple HLS Examples
/// https://developer.apple.com/streaming/examples/
/// Advanced stream
/// https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8

final class M3UTests: XCTestCase {
    
    /// Advanced stream (HEVC/H.264)
    /// https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8
    func testAdvancedStreamHEVC() async throws {
        let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
        let request = AF.request(url)
        let dataTask = request.serializingData()
        let data = try await dataTask.value
        let string = String(data: data, encoding: .utf8)!
        print(string)
        let m3u = M3U(string: string)!
        for tag in m3u.tags {
            print(tag)
        }
    }
}
