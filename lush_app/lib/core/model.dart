abstract interface class Model<T> {
  Map<String, dynamic> toMap();
  T copyWith(Map<String, dynamic> params);
}
