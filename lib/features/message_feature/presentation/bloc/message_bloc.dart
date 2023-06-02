import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../utils/failure_messages.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/create_message.dart';
import '../../domain/usecases/edit_message.dart';
import '../../domain/usecases/get_all_message.dart';
import '../../domain/usecases/get_message_by_id.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  late CreateMessage createMessage;
  late EditMessage editMessage;
  late GetAllMessages getAllMessages;
  late GetMessage getMessageById;

  MessageBloc({
    required CreateMessage createMessage,
    required EditMessage editMessage,
    required GetAllMessages getAllMessages,
    required GetMessage getMessageById,
  })  : createMessage = createMessage,
        editMessage = editMessage,
        getAllMessages = getAllMessages,
        getMessageById = getMessageById,
        super(EmptyMessage()) {
    on<CreateMessageEvent>(_onCreateMessage);
    on<EditMessageEvent>(_onEditSpecificTaskEvent);
    on<GetAllMessagesEvent>(_onGetAllMessagesEvent);
    on<SendMessageEvent>(_onGetMessageByIdEvent);
  }

  void _onCreateMessage(
    CreateMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    switch (event.runtimeType) {
      case CreateMessageEvent:
        emit(LoadingMessage());
        Either<Failure, void> response = await createMessage
            .call(CreateMessageParams(vendorEntity: event.messageEntity));
        return emit(
          await response.fold(
            (failure) => ErrorMessage(message: mapFailureToMessage(failure)),
            (message) => EmptyMessage(),
          ),
        );
      default:
        return emit(EmptyMessage());
    }
  }

  void _onEditSpecificTaskEvent(
    EditMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    switch (event.runtimeType) {
      case EditMessageEvent:
        emit(LoadingMessage());
        Either<Failure, void> response = await editMessage
            .call(EditMessageParams(messageEntity: event.messageEntity));
        return emit(
          await response.fold(
            (failure) => ErrorMessage(message: mapFailureToMessage(failure)),
            (message) => EmptyMessage(),
          ),
        );
      default:
        return emit(EmptyMessage());
    }
  }

  void _onGetAllMessagesEvent(
    GetAllMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    switch (event.runtimeType) {
      case GetAllMessagesEvent:
        emit(LoadingMessage());
        Either<Failure, List<MessageEntity>> response =
            await getAllMessages.call(NoParams());
        return emit(
          await response.fold(
            (failure) => ErrorMessage(message: mapFailureToMessage(failure)),
            (messageList) =>
                LoadedMessageList(messageList: messageList),
          ),
        );
      default:
        return emit(EmptyMessage());
    }
  }

  void _onGetMessageByIdEvent(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    print('ran _onGetMessageByIdEvent');
    switch (event.runtimeType) {
      case SendMessageEvent:
        emit(LoadingMessage());
        Either<Failure, MessageEntity> response = await getMessageById.call(
            GetMessageParam(
                messageEntity: event.messageEntity,
                targetLanguage: event.targetLanguage,
                messageIndex: event.messageIndex));
        return emit(
          await response.fold(
            (failure) => ErrorMessage(message: mapFailureToMessage(failure)),
            (message) => LoadedMessage(translation: message),
          ),
        );
      default:
        return emit(EmptyMessage());
    }
  }
}
