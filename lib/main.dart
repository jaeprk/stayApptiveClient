import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/user_model.dart';
import './pages/dashboard.dart';

void main() => runApp(MyApp(
      UserModel(),
    ));

// Appbar,
class MyApp extends StatelessWidget {
  final UserModel user;
  const MyApp(this.user);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: user,
        child: new MaterialApp(
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              accentColor: Colors.orange),
          routes: {
            '/': (BuildContext context) => Dashboard(),
          },
        ));
  }
}
