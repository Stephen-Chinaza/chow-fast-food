import 'dart:io';

import 'package:chow/ui/settings/kyc_verification/face_auth_screen.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';


import '../../../../handlers/image_handler.dart';
import '../../../widgets/image_view.dart';

class DocumentUpload extends StatefulWidget {
  final Function(File?) onSelected;
  final String description;
  final String icon;
  final bool selfie;
  const DocumentUpload({
    required this.onSelected,
    required this.description,
    required this.icon, Key? key})
      : selfie=false, super(key: key);

  const DocumentUpload.selfie({
    required this.onSelected,
    required this.description,
    required this.icon, Key? key})
      : selfie=true, super(key: key);

  @override
  State<DocumentUpload> createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {

  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.selfie
          ? _takeSelfie : _pickImage,
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Builder(
                builder: (context) {
                  if(_selectedFile!=null){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: ImageView.file(
                        _selectedFile!,
                        height: 150,
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageView.asset(widget.icon),
                      const SizedBox(height: 15),
                      Text(widget.description,
                          style: const TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w700))
                    ],
                  );
                }
              )
          )),
    );
  }

  void _pickImage()async {
    final image=await ImageHandler.pickImage(context, image: true);
    if(image!=null){
      final croppedImage= await ImageHandler.cropImage(File(image.path));
      setState(()=>_selectedFile=File(croppedImage?.path ?? image.path));
      widget.onSelected(_selectedFile);
    }
  }

  void _takeSelfie()async {
    final image= await AppNavigator.pushAndStackPage(
        context, page: const FaceAuthScreen());
    if(image!=null){
      setState(()=>_selectedFile=image);
      widget.onSelected(_selectedFile);
    }
  }

}
