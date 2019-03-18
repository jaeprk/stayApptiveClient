import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/user_model.dart';

class StepsIndicator extends StatefulWidget {
  @override
  _StepsIndicatorState createState() => _StepsIndicatorState();
}

class _StepsIndicatorState extends State<StepsIndicator> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Column(children: [
        Text('Steps',
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
            percent: model.stepsGoalPercent < 1 ? model.stepsGoalPercent : 1,
            center: new Text("${model.currentSteps} / ${model.stepsGoal}"),
            backgroundColor: Colors.white24,
            progressColor: Colors.white,
          )),
        ]))
      ]);
    });
  }
}
