import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrix/Screens/Profile/profile_screen.dart';
import 'package:nutrix/api/user_api.dart';
import 'package:nutrix/components/build_input_decoration.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfileScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  File? fileImage;
  String? imagePath;
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _phoneNumber = "";
  String _changePassword = "";
  String _confirmPassword = "";

  final formKey = GlobalKey<FormState>();

  bool _is_patient = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      fileImage = File(image.path);
      setState(() => imagePath = image.path);
    } on PlatformException catch (e) {
      print('Faield to pick image : $e');
    }
  }

  void _showCameraAction(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Update Profile Picture'),
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
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    var doUpdate = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        if (_changePassword == "" && _confirmPassword == "") {
          user
              .updateUser(
                  _email, _firstName, _lastName, _phoneNumber, _changePassword, imagePath)
              .then((response) {
            print(response);
            if (response['message'] == "Succesful") {
              print(response);
              print("succesful in edit ");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              ).then((result) => setState(() {}));
            } else {
              print(response['result']);
              print(response['message']);
            }
          });
          user.notify();
        } else if (_changePassword == _confirmPassword) {
          print("same password logic here");
        }
        else {
          print("something is wrong");
        }
      }
    };

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 8,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imagePath != null
                              ? AssetImage(imagePath!) as ImageProvider
                              : NetworkImage(
                                  user.user.profile_pic),
                        ),
                      ),
                    ),
                    onTap: () => _showCameraAction(context),
                  ),
                ),
                SizedBox(height: 15),
                Text("Email"),
                TextFormField(
                  autofocus: false,
                  initialValue: user.user.email,
                  // validator: validateEmail,
                  onSaved: (value) => _email = value!,
                  decoration: buildInputDecoration("Enter Email", Icons.email),
                ),
                SizedBox(height: 20),
                Text("First Name"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  initialValue: user.user.firstName,
                  onSaved: (value) => _firstName = value!,
                  decoration: buildInputDecoration(
                      "Enter First Name", Icons.text_fields),
                ),
                SizedBox(height: 20),
                Text("Last Name"),
                SizedBox(height: 5),
                TextFormField(
                  initialValue: user.user.lastName,
                  autofocus: false,
                  onSaved: (value) => _lastName = value!,
                  decoration: buildInputDecoration(
                      "Enter Last Name", Icons.text_fields),
                ),
                SizedBox(height: 20),
                Text("Phone Number"),
                SizedBox(height: 5),
                TextFormField(
                  initialValue: user.user.phoneNumber,
                  autofocus: false,
                  onSaved: (value) => _phoneNumber = value!,
                  decoration:
                      buildInputDecoration("Enter Phone Number", Icons.phone),
                ),
                SizedBox(height: 20),
                Text("Change Password"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => _changePassword = value!,
                  decoration:
                      buildInputDecoration("Enter Password", Icons.lock),
                ),
                SizedBox(height: 20),
                Text("Confirm Password"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => _confirmPassword = value!,
                  decoration: buildInputDecoration(
                      "Enter Confirm Password", Icons.lock),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: doUpdate,
                  textColor: kPrimaryLightColor,
                  color: kPrimaryColor,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Save Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: 45,
                  minWidth: 600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    centerTitle: true,
    title: const Text(
      "Edit Profile",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
