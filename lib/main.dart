import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  List? _result;

  @override
  void initState() {

    super.initState();
    loadModelData().then((output) {
//after loading models, rebuild the UI.
      setState(() {});
    });
  }
  loadModelData() async {
    //tensorflow lite plugin loads models and labels.
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _image != null ? testImage(size, _image) : titleContent(size),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  galleryOrCamera(Icons.camera, ImageSource.camera),
                  galleryOrCamera(Icons.photo_album, ImageSource.gallery),
                ]
            ),

            SizedBox(height: 50),
            _result != null && _result!.isNotEmpty
                ? Text(
              // '$_result',
              'It\'s a ${_result![0]['label']}.',
              style: GoogleFonts.openSansCondensed(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
                : Text(
              '1. Select or Capture the image. \n\n2. Tap the submit button.',
              style: GoogleFonts.openSans(fontSize: 16),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  elevation: 4,
                  primary: Colors.grey[300],
                ),
                onPressed:detectDogOrCat,
                //             onPressed: detectDogOrCat,
                child: Text(
                  'PREDICT',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 45),
            const Text(
              'Copyright mpdev.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
  Container titleContent(Size size) {
    return Container(
//contains 55% of the screen height.
      height: size.height * 0.55,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/face.gif"),
          fit: BoxFit.cover,
          scale: 0.2,
//black overlay filter
          // colorFilter: filter,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 270,
            ),



          ],
        ),
      ),
    );
  }
  MaterialButton galleryOrCamera(IconData icon, ImageSource imageSource) {
    return MaterialButton(
      padding: EdgeInsets.all(14.0),
      elevation: 5,
      color: Colors.grey[300],
      onPressed: () {
        _getImage(imageSource);
      },
      child: Icon(
        icon,
        size: 20,
        color: Colors.grey[800],
      ),
      shape: CircleBorder(),
    );
  }

  _getImage(ImageSource imageSource) async {
//accessing image from Gallery or Camera.
    final XFile? image = await _picker.pickImage(source: imageSource);

//image is null, then return
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      _result = null;
    });

  }

  Widget testImage(size, image) {
    return Container(
      height: size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            image!,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void detectDogOrCat() async {
    _result=[];
    if (_image != null) {
      try {

        _result = await Tflite.runModelOnImage(
          path: _image!.path,
           numResults: 7,
           threshold: 0.5,
           imageMean: 0.0,
           imageStd: 255.0,
        );
        print(_result);
        if(_result!.length<1){
        final snackBar = SnackBar(
          content: const Text('Oops! I am unable to identify emotion!'),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      } catch (e) {}

      setState(() {});
    }else{
      final snackBar = SnackBar(
        content: const Text('Select or Capture the image'),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
