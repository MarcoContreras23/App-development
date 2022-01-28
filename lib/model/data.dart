final String tableData = 'Qrdata';

class DataFields {
  static final List<String> values = [id, type, value];
  static final String id = 'id';
  static final String type = 'type';
  static final String value = 'value';
}

class Data {
  int? id;
  String type;
  String value;

  Data({this.id, required this.type, required this.value});

  Data copy({
    int? id,
    String? type,
    String? value,
  }) =>
      Data(
        id: id ?? this.id,
        type: type ?? this.type,
        value: value ?? this.value,
      );

  static Data fromJson(Map<String, Object?> json) => Data(
        id: json["id"] as int,
        type: json["type"] as String,
        value: json["value"] as String,
      );

  Map<String, Object?> toJson() => {
        DataFields.id: id,
        DataFields.type: type,
        DataFields.value: value,
      };
}
