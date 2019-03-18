import 'package:scoped_model/scoped_model.dart';
import '../models/google_fit.dart';
import 'dart:async';

class UserModel extends Model {
  int _currentSteps = 1;
  int _currentActiveMinutes = 1;
  int _stepsGoal = 10000;
  int _activeMinutesGoal = 100;

  UserModel() {
    Timer.periodic(new Duration(seconds: 10), (timer) async {
      await handleSignIn();
      await _updateData();
    });
  }

  int get stepsGoal {
    return _stepsGoal;
  }

  int get activeMinutesGoal {
    return _activeMinutesGoal;
  }

  int get currentActiveMinutes {
    return _currentActiveMinutes;
  }

  set stepGoal(int i) {
    _stepsGoal = i;
    notifyListeners();
  }

  int get currentSteps {
    return _currentSteps;
  }

  double get stepsGoalPercent {
    if (_stepsGoal == 0)
      return 0.0;
    else
      return _currentSteps / _stepsGoal;
  }

  double get activeMinutesGoalPercent {
    if (_activeMinutesGoal == 0)
      return 0.0;
    else
      return _currentActiveMinutes / _activeMinutesGoal;
  }

  Future<void> _updateData() async {
    var tmpSteps = await getData('step', 'month');
    var tmpActiveMinutes = await getData('activeMinute', 'month');
    _currentSteps = int.parse(tmpSteps[10]);
    _currentActiveMinutes =
        int.parse(tmpActiveMinutes[tmpActiveMinutes.length - 2]);
    //_currentSteps = int.parse(tmpSteps.last);
    notifyListeners();
  }
}
