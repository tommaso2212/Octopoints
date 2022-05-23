class Rule {
  final int id;
  final int matchId;
  final int numVincitori;
  final int total;
  final int totalIncrement;
  final bool partialIncrement;

  Rule({
    this.id = 0,
    required this.matchId,
    required this.numVincitori,
    required this.total,
    required this.totalIncrement,
    required this.partialIncrement
  });
}