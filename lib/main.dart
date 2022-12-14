import 'package:flutter/material.dart';


import './dummy_data.dart';
import './models/meals.dart';
import './screens/filters_screen.dart';
import './screens/tab_screen.dart';
import './screens/meals_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters ={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List<Meal> _availablemeals = DUMMY_MEALS;
  

  void _setFilters(Map<String,bool>filterdata){
      setState(() {
        _filters = filterdata;

        _availablemeals = DUMMY_MEALS.where((meal){
          if(_filters['gluten'] && !meal.isGlutenFree){
            return false;
          }
          if(_filters['lactose'] && !meal.isLactoseFree){
            return false;
          }
          if(_filters['vegan'] && !meal.isVegan){
            return false;
          }
          if(_filters['vegetarian'] && !meal.isVegetarian){
            return false;
          }
          return true;
        }).toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals Guide',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/' : (ctx) => TabScreen(),
        CategoryMealsScreen.routeName :(ctx) => CategoryMealsScreen(_availablemeals),
        MealDetailScreen.routeName :(ctx) => MealDetailScreen(),
        FiltersScreen.routeName:(ctx) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

