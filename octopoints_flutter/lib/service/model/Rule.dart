class Rule {
  final int id;
  final int matchId;
  final RuleIfArgumentEnum ifArgument;
  final RuleIfConditionEnum ifCondition;
  final int ifValue;
  final RuleThenArgumentEnum thenArgument;
  final int? thenValue;

  Rule({
    this.id = 0,
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

extension RuleIfArgumentEnumExtension on RuleIfArgumentEnum {
  String get name {
    switch(this){
      case RuleIfArgumentEnum.total: return "Total";
      case RuleIfArgumentEnum.partial: return "Partial";
      case RuleIfArgumentEnum.winners: return "Vincitori";
      case RuleIfArgumentEnum.losers: return "Sconfitti";
    }
  }
}

enum RuleIfConditionEnum {
  equals,
  greater,
  less,
}

extension RuleIfConditionEnumExtension on RuleIfConditionEnum {
  String get name {
    switch(this){
      case RuleIfConditionEnum.equals: return "=";
      case RuleIfConditionEnum.greater: return ">";
      case RuleIfConditionEnum.less: return "<";
    }
  }
}

enum RuleThenArgumentEnum {
  total,
  teamStatus,
  endGame,
}

extension RuleThenArgumentEnumExtension on RuleThenArgumentEnum {
  String get name {
    switch(this){
      case RuleThenArgumentEnum.endGame: return "Fine partita";
      case RuleThenArgumentEnum.teamStatus: return "Team status";
      case RuleThenArgumentEnum.total: return "Incrementa totale";
    }
  }
}