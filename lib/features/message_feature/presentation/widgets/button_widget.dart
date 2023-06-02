
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_software_synopsis/core/services/firebase_user_service.dart';

import '../../domain/entities/message_entity.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';

class MessageButtonWidget extends StatefulWidget {
  MessageButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageButtonWidget> createState() => _MessageButtonWidgetState();
}

class _MessageButtonWidgetState extends State<MessageButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          /*
          BlocProvider.of<MessageBloc>(context).add(
            CreateMessageEvent(
              messageEntity: MessageEntity(
                message: 'en',
                sender: getFirebaseUserUid(),
                timeStamp: Timestamp.now(),
              ),
            ),
          );
          Future.delayed(Duration(seconds: 5), (){
            BlocProvider.of<MessageBloc>(context)
                .add(GetAllMessagesEvent());
          });


           */
        },
        child: Text('Try message feature'));
  }
}
