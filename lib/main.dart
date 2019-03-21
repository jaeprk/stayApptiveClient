import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/user_model.dart';

import './pages/dashboard.dart';
import './pages/recommendation.dart';
import './pages/healthState.dart';
import './pages/inputActivity.dart';
import './pages/goal.dart';
import './pages/stepHistory.dart';
import './pages/activeMinuteHistory.dart';

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
            '/recommendation': (BuildContext context) =>
                Recommendation(), // gets health state and show recommandation
            '/healthState': (BuildContext context) =>
                HealthState(), // gets health state
            '/goal': (BuildContext context) =>
                Goal(), // show currunt goal and let the user change it
            '/inputActivity': (BuildContext context) =>
                InputActivity(), // input activity
            '/stepHistory': (BuildContext context) =>
                StepHistory(), // show step history of the month
            '/activeMinuteHistory': (BuildContext context) =>
                ActiveMinuteHistory() // show active minute history of the month
          },
        ));
  }
}
