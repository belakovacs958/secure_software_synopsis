import 'package:equatable/equatable.dart';

import '../../../message_feature/domain/entities/message_entity.dart';
import '../../domain/entities/message_entity.dart';



abstract class MessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateMessageEvent extends MessageEvent {
  final MessageEntity messageEntity;

  CreateMessageEvent({required this.messageEntity});

  @override
  List<Object> get props => [messageEntity];
}

class EditMessageEvent extends MessageEvent {
  final MessageEntity messageEntity;

  EditMessageEvent({required this.messageEntity});

  @override
  List<Object> get props => [messageEntity];
}

class GetAllMessagesEvent extends MessageEvent {

}

class SendMessageEvent extends MessageEvent {
  final MessageEntity messageEntity;
  final String targetLanguage;
  final int messageIndex;

  SendMessageEvent({required this.messageEntity, required this.targetLanguage,required this.messageIndex});

  @override
  List<Object> get props => [messageEntity,targetLanguage,messageIndex];
}
