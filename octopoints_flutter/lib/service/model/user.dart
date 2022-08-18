class User {
  final int id;
  final String username;
  int _win;
  int _lose;

  User({
    this.id = 0,
    required this.username,
    int win = 0,
    int lose = 0,
  })  : _win = win,
        _lose = lose;

  get win => _win;
  get lose => _lose;

  User addWin() {
    _win++;
    return this;
  }

  User addLose() {
    _lose++;
    return this;
  }
}
