class UserModel {
  int? _id;
  String _username;
  int _win = 0;
  int _lose = 0;

  UserModel.insert(this._username);

  UserModel(this._id, this._username, this._win, this._lose);

  int? get id => this._id;
  String get username => this._username;
  int get win => this._win;
  int get lose => this._lose;

  UserModel setId(int id) {
    this._id = id;
    return this;
  }

  UserModel incrementWin() {
    this._win += 1;
    return this;
  }

  UserModel incrementLose() {
    this._lose += 1;
    return this;
  }
}
