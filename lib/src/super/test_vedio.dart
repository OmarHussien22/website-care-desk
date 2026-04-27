// import 'dart:io';

// import '../../packages_index.dart';
// import '../features/exams/presentation/widgets/attachments/vedio_attachment.dart';

// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

// class TestVedio extends StatelessWidget {
//   const TestVedio({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: VideoAttachment(
//           video:
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//           // video: File('path/to/video/file.mp4'),
//         ),
//       ),
//     );
//   }
// }

// class VedioPlayer extends StatefulWidget {
//   const VedioPlayer({super.key});

//   @override
//   State<VedioPlayer> createState() => _VedioPlayerState();
// }

// class _VedioPlayerState extends State<VedioPlayer> {
//   late VideoPlayerController videoPlayerController;
//   late ChewieController chewieController;

//   @override
//   void initState() {
//     super.initState();

//     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

//     videoPlayerController.initialize();

//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Chewie(
//       controller: chewieController,
//     );
//   }
// }

