import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/user_model.dart';

class RecommendationIndicator extends StatefulWidget {
  @override
  _RecommendationIndicatorState createState() =>
      _RecommendationIndicatorState();
}

class _RecommendationIndicatorState extends State<RecommendationIndicator> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      var _fontColor = model.stageScore > 1 ? Colors.teal : Colors.red;
      return Column(children: [
        Text('Current Progress',
            style: TextStyle(
              fontSize: 20,
              color: _fontColor,
              decoration: TextDecoration.none,
            )),
        Container(
            //margin: const EdgeInsets.all(10.0),
            //padding: const EdgeInsets.all(10.0),
            child: Flex(direction: Axis.vertical, children: <Widget>[
          Center(
              child: CircularPercentIndicator(
            radius: 130.0,
            lineWidth: 9.0,
            percent: model.stageScore < 2 ? model.stageScore / 2 : 2,
            center: new Text("${(model.stageScore * 100).round()}%",
                style: TextStyle(color: _fontColor)),
            backgroundColor: Colors.white24,
            progressColor: Colors.red,
          )),
        ]))
      ]);
    });
  }
}
