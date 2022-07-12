import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/home_screen.dart';
import 'package:nutrix/api/calories_api.dart';
import 'package:nutrix/components/build_input_decoration.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';

class EditCaloriesScreen extends StatefulWidget {
  const EditCaloriesScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<EditCaloriesScreen> createState() => EditCaloriesState();
}

class EditCaloriesState extends State<EditCaloriesScreen> {
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    CaloriesProvider dailyCaloriesP = Provider.of<CaloriesProvider>(context);
    double _newCaloriesValue = dailyCaloriesP.dailyCalories.dailyCalories;
    // ignore: prefer_function_declarations_over_variables
    var doUpdateCalories = () {
      final form = formKey.currentState;
      if(form!.validate()) {
        form.save();
        dailyCaloriesP.updateCalories(_newCaloriesValue).then((response) {
          if(response['message'] == "Succesful") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              ).then((result) => setState(() {}));
          }
        });
      }
    };
    return ChangeNotifierProvider(
      create: (context) => CaloriesProvider(),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Max Calories"),
                  const SizedBox(height: 5),
                  TextFormField(
                    initialValue:
                        '${context.watch<CaloriesProvider>().dailyCalories.dailyCalories}',
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _newCaloriesValue = double.parse(value!),
                    decoration:
                        buildInputDecoration("Enter New Calories", Icons.numbers),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: doUpdateCalories,
                    textColor: kPrimaryLightColor,
                    color: kPrimaryColor,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    height: 45,
                    minWidth: 600,
                    shape: const RoundedRectangleBorder(
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
      ),
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
      "Calories Settings",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
