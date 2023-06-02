


import '../../../message_feature/domain/entities/message_entity.dart';
import '../../domain/entities/message_entity.dart';

abstract class MessageRemoteDataSource {
  /// Calls the https://api.morgen.so/tasks/create endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> createMessage(MessageEntity messageEntity);

  /// Calls the https://api.morgen.so/tasks/update endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> editMessage(MessageEntity messageEntity);

  Future<List<MessageEntity>> getAllMessages();
  Future<MessageEntity> getMessage(  MessageEntity messageEntity,
      String targetLanguage,
      int messageIndex,);


}