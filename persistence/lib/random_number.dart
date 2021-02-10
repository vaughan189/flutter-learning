class RandomNumber {
  int value;
  DateTime createdTime;
  RandomNumber(this.value, this.createdTime);

  RandomNumber.fromMap(Map<String, dynamic> map)
      : assert(map["value"] != null),
        assert(map["createdTime"] != null),
        value = map["value"],
        createdTime = map["createdTime"] is String
            ? DateTime.parse(map["createdTime"])
            : map["createdTime"];

  Map<String, dynamic> toMap() {
    return {
      "value": this.value,
      "createdTime": this.createdTime.toString(),
    };
  }
}
