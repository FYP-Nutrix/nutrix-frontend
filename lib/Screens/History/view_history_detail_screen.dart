import 'package:flutter/material.dart';
import 'package:nutrix/components/my_bottom_nav_bar.dart';
import 'package:nutrix/constrants.dart';

class ViewHistoryDetailsScreen extends StatefulWidget {
  const ViewHistoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ViewHistoryDetailsScreen> createState() => _ViewHistoryDetailsState();
}

class _ViewHistoryDetailsState extends State<ViewHistoryDetailsScreen> {
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
                  'https://www.seriouseats.com/thmb/_BkW9V2wK3Zed-zQAETkRSJS8ac=/1500x1125/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2018__04__20180309-french-fries-vicky-wasik-15-5a9844742c2446c7a7be9fbd41b6e27d.jpg',
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Text(
                'Food Nutrition',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Food Name: French Fried",
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "Calories: 95",
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                "Meal Size: 1",
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
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
      "View Meal Diary",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
