import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/user_model.dart';

class ActiveMinutesIndicator extends StatefulWidget {
  @override
  _ActiveMinutesIndicatorState createState() => _ActiveMinutesIndicatorState();
}

class _ActiveMinutesIndicatorState extends State<ActiveMinutesIndicator> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Column(children: [
        Text('Active Minutes',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              decoration: TextDecoration.none,
            )),
        Container(
            //margin: const EdgeInsets.all(10.0),
            //padding: const EdgeInsets.all(10.0),
            child: Flex(direction: Axis.vertical, children: <Widget>[
          Center(
              child: CircularPercentIndicator(
            radius: 160.0,
            lineWidth: 9.0,
            percent: model.activeMinutesGoalPercent < 1
                ? model.activeMinutesGoalPercent
                : 1,
            center: new Text(
                "${model.currentActiveMinutes} / ${model.activeMinutesGoal}"),
            backgroundColor: Colors.white24,
            progressColor: Colors.white,
          )),
        ])),
      ]);
    });
  }
}
