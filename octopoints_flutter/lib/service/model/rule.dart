class Rule {
  final int id;
  final int matchId;
  int winners;
  int total;

  Rule({
    this.id = 0,
    required this.matchId,
    required this.winners,
    required this.total,
  });

  Rule setTotal(int total){
    this.total = total;
    return this;
  }

  Rule setWinners(int winners){
    this.winners = winners;
    return this;
  }
}