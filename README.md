# M3U

M3U Parser, for edit or create m3u list, write in Swift.

## Supportted Tags

| Tag | struct | remark |
| ---- | ---- | ---- | 
| #EXT-X-VERSION | `EXT_X_VERSION` | |
| #EXTM3U | `EXTM3U` | |
| #EXT-X-BITRATE | `EXT_X_BITRATE` | Not find in RFC8216, but APPLE use it in [Examples](https://developer.apple.com/streaming/examples)|
| #EXT-X-BYTERANGE | `EXT_X_BYTERANGE` | |
| #EXT-X-KEY | `EXT_X_KEY` | |
| #EXT-X-MAP | `EXT_X_MAP` | |
| #EXTINF | `EXTINF` | |
| #EXT-X-ENDLIST | `EXT_X_ENDLIST` | |
| #EXT-X-MEDIA-SEQUENCE | `EXT_X_MEDIA_SEQUENCE` | |
| #EXT-X-PLAYLIST-TYPE | `EXT_X_PLAYLIST_TYPE` | |
| #EXT-X-TARGETDURATION | `EXT_X_TARGETDURATION` | |
| #EXT-X-I-FRAME-STREAM-INF | `EXT_X_I_FRAME_STREAM_INF` | |
| #EXT-X-MEDIA | `EXT_X_MEDIA` | |
| #EXT-X-STREAM-INF | `EXT_X_STREAM_INF` | |
| #EXT-BLANK-LINE | `EXT_BLANK_LINE` | Only used in framework for serialize |
| #EXT-UNKNOWNE | `EXT_UNKNOWN` | Only used in framework for serialize |

## Reference

* [HTTP Live Streaming (RFC8216)](https://datatracker.ietf.org/doc/html/rfc8216)
* [Apple HTTP Live Streaming Examples](https://developer.apple.com/streaming/examples)

## License

M3U is released under the MIT license. See [LICENSE](./LICENSE) for details.
