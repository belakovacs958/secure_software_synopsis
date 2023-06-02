import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required String message,
      required String sender,
      required String receiver,
      required Timestamp timeStamp})
      : super(
          message: message,
          sender: sender,
          receiver: receiver,
          timeStamp: timeStamp,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timeStamp': timeStamp
    };
  }
}
