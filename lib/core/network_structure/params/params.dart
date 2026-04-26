abstract class Params {
  Map<String, dynamic> toJson();
  Map<String, dynamic> futureToJson() {
    return {};
  }

  Map<String, dynamic> query() {
    return {};
  }
}

class NoParams extends Params {
  factory NoParams() => _instance;
  NoParams._internal();
  static final NoParams _instance = NoParams._internal();
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
