import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  String message;
  String sender;
  String receiver;
  Timestamp timeStamp;

  MessageEntity(
      {required this.message,
      required this.sender,
      required this.receiver,
      required this.timeStamp});

  @override
  List<Object?> get props => [message, sender, receiver, timeStamp];
}
