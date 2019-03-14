import 'package:flutter/material.dart';
import './google_fit.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductControl extends StatefulWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  _ProductControlState createState() => _ProductControlState();
}

class _ProductControlState extends State<ProductControl> {
  String steps = "0";
  int goalSteps = 10000;
  _getStepPercent() {
    double rst = double.parse(steps) / goalSteps;
    if (rst > 1 || rst < 0) {
      return 1;
    } else {
      return rst;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: <Widget>[
      Center(
          child: CircularPercentIndicator(
        radius: 160.0,
        lineWidth: 9.0,
        percent: double.parse(steps) / goalSteps,
        center: new Text("${steps} / ${goalSteps}"),
        progressColor: Colors.red,
      )),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          handleSignIn();
        },
        child: Text('google siginin'),
      ),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          handleSignOut();
        },
        child: Text('google signout'),
      ),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          print(getSteps('day'));
        },
        child: Text('get step for day'),
      ),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          var list = await getSteps('month');
          for (var a in list) {
            print(a);
          }
        },
        child: Text('get step for month'),
      ),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          var stepsContainer = await getSteps('month');
          int index = stepsContainer.length - 2;
          setState(() {
            steps = stepsContainer[index];
          });
        },
        child: Text('update step'),
      ),
    ]);
  }
}
