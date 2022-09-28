import 'package:json_annotation/json_annotation.dart';

part 'message_unread_filter.g.dart';

@JsonSerializable()
class MessageUnreadFilter {
  int? partnerId; //Partner id

  MessageUnreadFilter({
    this.partnerId,
  });

  Map<String, dynamic> toJson() => _$MessageUnreadFilterToJson(this);
}