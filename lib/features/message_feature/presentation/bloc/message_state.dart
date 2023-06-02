

import 'package:equatable/equatable.dart';

import '../../domain/entities/message_entity.dart';



abstract class MessageState  extends Equatable{

}
class EmptyMessage extends MessageState {
  @override
  List<Object> get props => [];
}

class LoadingMessage  extends MessageState {

  @override
  List<Object> get props => [];
}

class LoadedMessageList  extends MessageState {

  final List<MessageEntity> messageList;

  LoadedMessageList ({required this.messageList});

  @override
  List<Object> get props => [messageList];
}
class LoadedMessage extends MessageState {

  final MessageEntity translation;

  LoadedMessage ({required this.translation});

  @override
  List<Object> get props => [translation];
}


class ErrorMessage  extends MessageState {
  final String message;

  ErrorMessage ({required this.message});

  @override
  List<Object> get props => [message];
}
