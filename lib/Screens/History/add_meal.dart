import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrix/Screens/History/fake.dart';
import 'package:nutrix/api/meal_logging_api.dart';
import 'package:nutrix/components/build_input_decoration.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  File? image;
  String? imagePath;
  String _mealType = "";

  final formKey = GlobalKey<FormState>();

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

    var doAddMeal = () {
      final form = formKey.currentState;
      if(form!.validate()) {
        form.save();
        // File imageFile = new File(imagePath!);
        // List<int> imageBytes = imageFile.readAsBytesSync();
        // String base64Image = base64.encode(imageBytes);
        mealP.addMeal(_mealType, imagePath!).then((response) {
          print(response);
        });
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
                child: TextFormField(
                  autofocus: false,
                  // validator: validateEmail,
                  onSaved: (value) => _mealType = value!,
                  decoration: buildInputDecoration(
                      "Enter Meal Name", Icons.food_bank_sharp),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return fakescreen();
                  },
                ),
              ).then((result) => setState(() {}));
        },
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
