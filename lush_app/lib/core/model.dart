abstract class BaseModel<T> {
  const BaseModel();

  Map<String, dynamic> toMap();

  T copyWith();

  @override
  String toString() => toMap().toString();

  static T fromMap<T extends BaseModel>(
          Map<String, dynamic> map, T Function(Map<String, dynamic>) create) =>
      create(map);
}
