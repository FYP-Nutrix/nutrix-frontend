import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrix/Screens/History/fake.dart';
import 'package:nutrix/Screens/History/history_screen.dart';
import 'package:nutrix/api/meal_logging_api.dart';
import 'package:nutrix/api/user_api.dart';
import 'package:nutrix/components/build_input_decoration.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  File? image;
  String? imagePath;

  final formKey = GlobalKey<FormState>();
  final List<String> mealType = ['BREAKFAST', 'LUNCH', 'DINNER', 'SUPPER'];
  // form values
  String _currentMeayType = "BREAKFAST";

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => imagePath = image.path);
    } on PlatformException catch (e) {
      print('Faield to pick image : $e');
    }
  }

  void _showCameraAction(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Add new Meal Diary'),
        message: const Text('Choose the type of action'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () => pickImage(ImageSource.camera),
            child: const Text('Take Picture with Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => pickImage(ImageSource.gallery),
            child: const Text('Choose Picture from Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this._showCameraAction(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    MealProvider mealP = Provider.of<MealProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);

    void sendMeal() async {
      // create request
      var request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.mealLogging));
      // payload creation here
      request.fields['meal_type'] = _currentMeayType;
      request.fields['user'] = user.user.userID;
      request.files.add(http.MultipartFile.fromBytes(
          'meal_image[0]meal_image', File(imagePath!).readAsBytesSync(),
          filename: imagePath));

      var response = await request.send();

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HistoryScreen();
            },
          ),
        ).then((result) => setState(() {}));
      }
    }

    var doAddMeal = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        sendMeal();
      }
    };

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  imagePath != null ? imagePath! : 'assets/images/images.png',
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Add Meal Diary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                  key: formKey,
                  child: DropdownButtonFormField(
                    items: mealType.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e'),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      _currentMeayType = value.toString();
                    }),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doAddMeal,
        backgroundColor: Colors.green,
        child: Icon(Icons.check),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    centerTitle: true,
    title: const Text(
      "Add New Meal Diary",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
