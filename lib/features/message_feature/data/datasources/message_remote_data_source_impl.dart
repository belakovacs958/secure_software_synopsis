import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../core/services/firebase_user_service.dart';
import '../../../../core/throw_server_exception.dart';

import 'package:http/http.dart' as http;

import '../../../../utils/collection_names.dart';
import '../../../message_feature/domain/entities/message_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../models/message_model.dart';
import 'message_remote_data_source.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  MessageRemoteDataSourceImpl({required this.client});

  CollectionReference messageCollection =
      FirebaseFirestore.instance.collection(MESSAGES_COLLECTION);
  late final http.Client client;

  @override
  Future<void> createMessage(MessageEntity messageEntity) async {
    var map = {
      'message': messageEntity.message,
      'sender': messageEntity.sender,
      'receiver': messageEntity.receiver,
      'timeStamp': messageEntity.timeStamp,
    };
    try {
      await FirebaseFirestore.instance.collection(MESSAGES_COLLECTION).add(map);
    } on FirebaseException catch (e) {
      throwException(e);
    }
  }


  @override
  Future<void> editMessage(MessageEntity messageEntity) async {
    try {
      var map = {};
      //await messageCollection.doc(messageEntity.uid).update(map);
    } on FirebaseException catch (e) {
      throwException(e);
    }
  }

  @override
  Future<List<MessageEntity>> getAllMessages() async {
    List<MessageModel> messages = [];
    try {
      await FirebaseFirestore.instance
          .collection(MESSAGES_COLLECTION)
          .get()
          .then(
            (data) => data.docs.forEach(
              (doc) {
                print("data:");
                print(doc.data() as Map<String, dynamic>);
                final MessageModel message =
                    MessageModel.fromJson(doc.data() as Map<String, dynamic>);
                messages.add(message);
              },
            ),
          );


    } on FirebaseException catch (e) {
      throwException(e);
    }
    return messages;
  }


  @override
  Future<MessageEntity> getMessage(
    MessageEntity messageEntity,
    String targetLanguage,
    int messageIndex,
  ) async {
    throw UnimplementedError();
  }
}
