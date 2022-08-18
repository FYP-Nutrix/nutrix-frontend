import 'package:flutter/material.dart';
import 'package:nutrix/Screens/History/view_history_detail_screen.dart';
import 'package:nutrix/api/meal_list_api.dart';
import 'package:nutrix/constrants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BodyClass extends StatefulWidget {
  const BodyClass({Key? key}) : super(key: key);

  @override
  State<BodyClass> createState() => _BodyState();
}

class _BodyState extends State<BodyClass> {
  @override
  Widget build(BuildContext context) {
    final meal = Provider.of<MealListProvider>(context);
    return SafeArea(
      child: ListView.builder(
        itemCount: meal.mealList.length,
        itemBuilder: (BuildContext build, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: Text(meal.mealList[index].mealType),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(meal.mealList[index].dateTime)),
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.network(meal.mealList[index].mealImage![0].mealImage),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Total Calories is : " + meal.mealList[index].mealImage![0].totalCalories.toString(),
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Food Detected : " + meal.mealList[index].mealImage![0].mealName,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewHistoryDetailsScreen(meal: meal.mealList[index]),
                      ),
                    );
                      },
                      child: const Text('View'),
                      textColor: kPrimaryColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: GridView.builder(
//                 itemCount: recipeBundles.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 20,
//                   childAspectRatio: 1.65,
//                 ),
//                 itemBuilder: (context, index) => RecipeBundelcard(
//                   recipeBundle: recipeBundles[index],
//                   press: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewHistoryDetailsScreen()));
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
