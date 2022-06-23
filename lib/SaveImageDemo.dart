import 'package:flutter/material.dart';
import 'package:save_image_shared_prefs/CamUtils.dart';
import 'dart:io';
import 'Utility.dart';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Flutter Save Image in Preferences";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {

    Image imageFromPreferences= Image.asset("");

  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

   @override
  void initState() {
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              this._launchPicker(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loadImageFromPreferences();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
           // imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
             imageFromPreferences,
          ],
        ),
      ),
    );
  }

  void _launchPicker(BuildContext cntxt) async {
    CamUtils.openSelector(cntxt, _processSelectedImage);
  }

  void _processSelectedImage(File? img) async {
    if (img != null) {
      print('Imageee$img');
      Utility.saveImageToPreferences(Utility.base64String(img.readAsBytesSync()));
    } else {
    }
  }

}