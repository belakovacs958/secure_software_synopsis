import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_software_synopsis/core/services/firebase_user_service.dart';
import 'package:secure_software_synopsis/features/message_feature/helpers/count_contacts.dart';
import 'package:secure_software_synopsis/features/message_feature/presentation/bloc/message_state.dart';
import 'package:secure_software_synopsis/utils/route_names.dart';

import '../message_feature/domain/entities/message_entity.dart';
import '../message_feature/presentation/bloc/message_bloc.dart';
import '../message_feature/presentation/bloc/message_event.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<MessageBloc>(context).add(
                  CreateMessageEvent(
                    messageEntity: MessageEntity(
                      message: 'en',
                      sender: getFirebaseUserUid(),
                      receiver: 'slvSr6wAF9Rix6YVsdbDLXiSwdj2',
                      timeStamp: Timestamp.now(),
                    ),
                  ),
                );
                Future.delayed(Duration(seconds: 5), () {
                  BlocProvider.of<MessageBloc>(context)
                      .add(GetAllMessagesEvent());
                });
              },
              child: Text('Try contacts feature')),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<MessageBloc>(context).add(
                  GetAllMessagesEvent(),
                );
                Future.delayed(Duration(seconds: 5), () {
                  BlocProvider.of<MessageBloc>(context)
                      .add(GetAllMessagesEvent());
                });
              },
              child: Text('Try get messages feature')),
          Container(
            height: 500,
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                print(state.runtimeType.toString());
                if (state is LoadedMessageList) {
                  print(state.messageList.first);
                  List<String> contacts = countContacts(state.messageList);
                  return ListView.builder(
                    itemCount: contacts.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            context.pushNamed(KEY_INPUT_PAGE,
                                queryParams: {'contact': contacts[index]});
                          },
                          child: Text(contacts[index]));
                    },
                  );
                } else if (state is LoadingMessage) {
                  return Center(
                    child: SpinKitCircle(
                      color: colorScheme.primary,
                      size: 30,
                    ),
                  );
                } else if (state is ErrorMessage) {
                  return Center(
                    child: Text(
                      "Message failed",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return Text('Default');
              },
            ),
          )
        ],
      ),
    );
  }
}
