import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:secure_software_synopsis/core/services/firebase_user_service.dart';
import 'package:secure_software_synopsis/features/message_feature/helpers/message_enryption.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/message_entity.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';
import '../bloc/message_state.dart';

class ChatPage extends StatefulWidget {
  Map<String, String> queryParams;

  ChatPage({required this.queryParams});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = types.User(
    id: getFirebaseUserUid(),
  );

  @override
  void initState() {
    super.initState();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    /*
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

     */
    BlocProvider.of<MessageBloc>(context).add(
      CreateMessageEvent(
        messageEntity: MessageEntity(
          message: encryptMessage(widget.queryParams['key']!, message.text),
          sender: getFirebaseUserUid(),
          receiver: widget.queryParams['contact']!,
          timeStamp: Timestamp.now(),
        ),
      ),
    );
    Future.delayed(Duration(seconds: 5), () {
      BlocProvider.of<MessageBloc>(context).add(GetAllMessagesEvent());
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: ElevatedButton(
          onPressed: () {
            BlocProvider.of<MessageBloc>(context).add(
              GetAllMessagesEvent(),
            );
          },
          child: Text(
            'Get messages',
          ),
        ),
        body: BlocListener<MessageBloc, MessageState>(
          listener: (context, state) {
            if (state is LoadedMessageList) {
              List<types.Message> messageList = [];
              state.messageList
                  .sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
              state.messageList.forEach((element) {
                element.message = decryptMessage(element.message, widget.queryParams['key']!);
              });
              state.messageList.forEach((element) {
                messageList.add(types.TextMessage(
                  author: types.User(
                    id: element.sender,
                  ),
                  createdAt: element.timeStamp.millisecondsSinceEpoch,
                  id: const Uuid().v4(),
                  text: element.message,
                ));
              });

              setState(() {
                _messages = messageList;
              });
            }
          },
          child: Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: _user,
          ),
        ),
      );
}
