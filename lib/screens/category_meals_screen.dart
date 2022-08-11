import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  final List<Meal> availablemeals;

  CategoryMealsScreen(this.availablemeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categorytitle;
  List<Meal>displayedmeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
   if(!_loadedInitData){ final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

     categorytitle = routeargs['title'];
    final categoryid = routeargs['id'];

    displayedmeals = widget.availablemeals.where((meal) {
      return meal.categories.contains(categoryid);
    }).toList();}

    super.didChangeDependencies();
  }

  void _removeMeal(String mealid){
    setState(() {
      displayedmeals.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categorytitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedmeals[index].id,
              title: displayedmeals[index].title,
              imageUrl: displayedmeals[index].imageUrl,
              affordability: displayedmeals[index].affordability,
              complexity: displayedmeals[index].complexity,
              duration: displayedmeals[index].duration,
              calory: displayedmeals[index].calory,
              removeitem: _removeMeal,
            );
          },
          itemCount: displayedmeals.length,
        ));
  }
}
