class MatchModel {
  int? _id;
  String _description;
  GameMode _gameMode;
  int _points;
  int _survivors;

  MatchModel.insert(
      this._description, this._gameMode, this._points, this._survivors);

  MatchModel(this._id, this._description, this._gameMode, this._points,
      this._survivors);

  int? get id => this._id;
  String get description => this._description;
  GameMode get gamemode => this._gameMode;
  int get points => this._points;
  int get survivors => this._survivors;

  MatchModel setId(int id) {
    this._id = id;
    return this;
  }
}

enum GameMode {
  firstToTotal, //Si vince non appena si raggiunge il punteggio fissato, perde chi rimane
  lastToTotal, //Quando si arriva al punteggio fissato si muore, vince chi rimane
}
