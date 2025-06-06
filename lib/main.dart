import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveapp/data/hive_data_store.dart';
import 'package:hiveapp/models/task.dart';
import 'package:hiveapp/view/home/home_view.dart';

void main() async{

  // Init hive DB brfore runapp
  await Hive.initFlutter();

  // Register hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // open a box
  var box = await Hive.openBox<Task>(HiveDataStore.boxName);


  // this is step is not necessary
  // delete data from previous day
  for (var task in box.values) {
        if (task.createdAtTime.day != DateTime.now().day) {
          task.delete();
        } else {

        }
      }

  runApp(BaseWidget(child: MyApp()));
}


// the inherited widget provides us with a convenient way
// to pass data betwwen widgets. while developing an app
// you will need some data from your parent's widgets or
// grant parent widgets or maybe beyond that
class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required this.child}) : super(child: child);
  final HiveDataStore dataStore = HiveDataStore();
  @override
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError("Could not find ancestor widget of type BaseWidget");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home:  HomeView(),
    );
  }
}

