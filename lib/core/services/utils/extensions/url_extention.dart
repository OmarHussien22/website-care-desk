extension UrlExtension on String {
  String? get youtubeId {
    final Uri? uri = Uri.tryParse(this);
    if (uri == null) return null;

    // Handle full-length YouTube links
    if (uri.host.contains('youtube.com')) {
      // ?v=VIDEO_ID
      if (uri.path == '/watch' && uri.queryParameters['v'] != null) {
        return uri.queryParameters['v'];
      }

      // /embed/VIDEO_ID
      if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'embed') {
        return uri.pathSegments[1];
      }

      // /v/VIDEO_ID
      if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'v') {
        return uri.pathSegments[1];
      }

      // /shorts/VIDEO_ID
      if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'shorts') {
        return uri.pathSegments[1];
      }
    }

    // Handle shortened youtu.be links: https://youtu.be/VIDEO_ID
    if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments[0];
    }

    return null;
  }
}

// Future<void> printVideoQualities(String videoId) async {
//   var yt = YoutubeExplode();
//
//   try {
//     // Get video info
//     var video = await yt.videos.get(videoId);
//
//     // Get manifest of available streams
//     var manifest = await yt.videos.streamsClient.getManifest(videoId);
//
//     // Get all video-only streams sorted by quality
//     var videoStreams = manifest.videoOnly.sortByVideoQuality();
//
//     print('Available video qualities for ${video.title}:');
//
//     for (var streamInfo in videoStreams) {
//       print('Quality: ${streamInfo.videoQuality.label}, '
//           'Codec: ${streamInfo.codec}, '
//           'Bitrate: ${streamInfo.bitrate.kiloBitsPerSecond} kbps');
//     }
//   } catch (e) {
//     print('Error: $e');
//   } finally {
//     yt.close();
//   }
// }
