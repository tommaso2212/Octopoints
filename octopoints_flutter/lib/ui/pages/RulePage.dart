import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/providers/RuleProvider.dart';

class RulePage extends StatelessWidget {
  final Match _match;
  late RuleProvider _ruleProvider;
  
  RulePage(this._match){
    _ruleProvider = RuleProvider(_match);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}