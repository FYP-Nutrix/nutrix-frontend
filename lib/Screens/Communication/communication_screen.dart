import 'package:flutter/material.dart';
import 'package:nutrix/api/calories_api.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({Key? key}) : super(key: key);

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: Image.network(
                  'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Text(
                'Feedback',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '${context.watch<CaloriesProvider>().dailyCalories.advice}',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: Icon(Icons.check_circle),
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
      "Communication",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
