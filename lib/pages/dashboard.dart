import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/steps_indicator.dart';
import '../widgets/active_minutes_indicator.dart';
import '../widgets/recommendation_indicator.dart';
import '../scoped-models/user_model.dart';
// This is Dashboard class, basically a home page

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(title: Center(child: Text('StayApptive'))),
        body: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(children: [
            Container(child: RecommendationIndicator()),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 30.0),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/stepHistory');
                      },
                      child: StepsIndicator(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/activeMinuteHistory');
                      },
                      child: ActiveMinutesIndicator(),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: RaisedButton(
                          color: Colors.black,
                          child: Text('Health State'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/healthState');
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: RaisedButton(
                          color: Colors.black,
                          child: Text('Input Activity'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/inputActivity');
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: RaisedButton(
                          color: Colors.black,
                          child: Text('Set Goal'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/goal');
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      child: RaisedButton(
                          color: Colors.black,
                          child: Text('Recommendation'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/recommendation');
                          }),
                    ),
                  ]),
                ),
              ],
            ),
          ]),
        ),
        backgroundColor: Colors.black,
      );
    });
  }
}
