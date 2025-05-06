import 'package:flutter/material.dart';
import 'package:infinity_scroll/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        NavigationService.setAppContext(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.0,
          fontFamily: "Roboto",
        ),
      ),
      initialRoute: Routes.mainScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static late BuildContext _context;

  static BuildContext get appContext =>  _context;
  static setAppContext(BuildContext context) {
    _context = context;
  }
}
