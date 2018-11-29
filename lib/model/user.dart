class User {
  String _name;
  String _token;

  User(this._name, [this._token]);

  User.map(dynamic obj) {
    this._name = obj["profile"]['name'];
    this._token = obj["session_token"];
  }

  String get name => _name;
  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["token"] = _token;

    return map;
  }
}
