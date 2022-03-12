class Rule {
  final int id;
  final int matchId;
  final RuleIfArgumentEnum ifArgument;
  final RuleIfConditionEnum ifCondition;
  final int ifValue;
  final RuleThenArgumentEnum thenArgument;
  final int? thenValue;

  Rule({
    required this.id,
    required this.matchId,
    required this.ifArgument,
    required this.ifCondition,
    required this.ifValue,
    required this.thenArgument,
    this.thenValue,
  });
}

enum RuleIfArgumentEnum {
  total,
  partial,
  winners,
  losers,
}

enum RuleIfConditionEnum {
  equals,
  greater,
  less,
}

enum RuleThenArgumentEnum {
  total,
  teamStatus,
  endGame,
}
