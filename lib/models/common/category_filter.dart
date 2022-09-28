import 'package:json_annotation/json_annotation.dart';

part 'category_filter.g.dart';

@JsonSerializable()
class CategoryFilter {
  int? studentId; // Student Id

  CategoryFilter({
    this.studentId,
  });

  Map<String, dynamic> toJson() => _$CategoryFilterToJson(this);
}
