class AttributeCardRequestModel {
  String? name;
  String? value;

  AttributeCardRequestModel({this.name, this.value});

  factory AttributeCardRequestModel.fromJson(Map<String, dynamic> map) {
    return AttributeCardRequestModel(
      name: map['name'] as String?,
      value: map['value'] as String?,
    );
  }
}
