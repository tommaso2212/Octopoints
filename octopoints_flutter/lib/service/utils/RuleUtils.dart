import 'package:octopoints_flutter/service/model/Rule.dart';

class RuleUtils {
  static bool isCondition(int value, Rule rule){
    switch(rule.ifCondition){
      case RuleIfConditionEnum.equals:
        return value == rule.ifValue;
      case RuleIfConditionEnum.greater:
        return value > rule.ifValue;
      case RuleIfConditionEnum.less:
        return value < rule.ifValue;
    }
  }
}