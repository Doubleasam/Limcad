abstract class FromJson<T> {
  T fromJson(Map<String, dynamic> data);
}

class TypeDecodable<T> implements FromJson<TypeDecodable<T>> {
  T value;
  TypeDecodable({required this.value});

  @override
  TypeDecodable<T> fromJson(dynamic data) {
    value = data;
    return this;
  }
}
