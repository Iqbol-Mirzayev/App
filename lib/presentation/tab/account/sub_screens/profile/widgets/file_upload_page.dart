import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopping/utils/ui_needs/color.dart';
import 'package:shopping/utils/ui_needs/style.dart';

import '../../../../../../utils/my_utils.dart';


class FileUploadPage extends StatefulWidget {
  const FileUploadPage({Key? key}) : super(key: key);

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  UploadTask? uploadTask;
  PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload image"),
      ),
      body: Column(
        children: [
          Expanded(
            child: pickedFile != null
                ? Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                  )
                : const SizedBox(),
          ),
          ElevatedButton(onPressed: selectFile, child: Text("Select File")),
          ElevatedButton(onPressed: uploadFile, child: Text("Upload File")),
          buildProgressBar(),
        ],
      ),
    );
  }

  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    } else {
      MyUtils.getMyToast(message: "File not picked");
    }
  }

  Future<void> uploadFile() async {
    String storagePath = "files/images/${pickedFile!.name}";
    var ref = FirebaseStorage.instance.ref().child(storagePath);
    setState(() {
      uploadTask = ref.putFile(File(pickedFile!.path!));
    });
    var snapshot = await uploadTask!.whenComplete(() => {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
  }

  Widget buildProgressBar() {
    if (uploadTask != null) {
      return StreamBuilder<TaskSnapshot>(
          stream: uploadTask!.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              double progress = data.bytesTransferred / data.totalBytes;
              return SizedBox(
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                    ),
                    Center(
                      child: Text(
                        "${(100 * progress).roundToDouble()} %",
                        style: MyTextStyle.sfProRegular.copyWith(
                          color: MyColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox(height: 50);
          });
    } else {
      return const SizedBox(
        height: 50,
      );
    }
  }
}