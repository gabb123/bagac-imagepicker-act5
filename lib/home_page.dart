import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? imgs;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity 5 Image Picker Sample",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black45
          ),
        ),
        backgroundColor: Colors.white60,
        leading: const Icon(Icons.image_rounded, color: Colors.black45,),
      ),

      body: Align(
        alignment: const Alignment(0.0, 0.0),
        child: Column(
          children: [
            const SizedBox(height: 35,),

            const Text("A photo from your gallery",
              style: TextStyle(
                fontFamily: 'Enrique',
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 15,),

            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  border:
                  Border.all(color: Colors.black, width: 1)),
              child: Center(
                  child: imgs == null ?
                  const Icon(Icons.image, size: 50,) :
                  Image.file(imgs!, fit: BoxFit.fill, height: double.infinity, width: double.infinity,)
              ),
            ),

            const SizedBox(height: 10,),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black45)
              ),
                onPressed: () async {
                  PermissionStatus storageStatus =
                      await Permission.storage.request();

                  if (storageStatus == PermissionStatus.granted){
                    XFile? img = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imgs = File(img!.path);
                    });
                  }

                  if (storageStatus == PermissionStatus.denied){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("This permission is required")));
                  }

                  if (storageStatus == PermissionStatus.permanentlyDenied){
                    openAppSettings();
                  }
                },
                child: const Text("Choose photo from gallery"),
            )
          ],
        ),
      )
    );
  }
}
