import 'dart:io';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';


class FaceAuthScreen extends StatelessWidget {
  const FaceAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SmartFaceCamera(
                autoCapture: true,
                showControls: false,
                defaultCameraLens: CameraLens.front,
                message: 'Center your face in the square',
                onCapture: (File? image)=>Navigator.pop(context, image),
                messageBuilder: (context, face) {
                  if (face == null) {
                    return _message('Place your face in the camera');
                  }
                  if (!face.wellPositioned) {
                    return _message('Center your face in the square');
                  }
                  return const SizedBox.shrink();
                }
            ),
            SafeArea(
              child: Align(alignment: Alignment.topLeft,
                child: IconButton(onPressed: ()=>Navigator.pop(context),
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                    icon: const Icon(Icons.clear, size: 34)),
              ),
            )
          ],
        )
    );
  }

  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );

}
