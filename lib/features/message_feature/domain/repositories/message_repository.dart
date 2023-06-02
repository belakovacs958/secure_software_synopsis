
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';

abstract class MessageRepository {
  Future<Either<Failure, void>> createMessage(MessageEntity message);

  Future<Either<Failure, void>> editMessage(MessageEntity message);

  Future<Either<Failure, List<MessageEntity>>> getAllMessages();

  Future<Either<Failure, MessageEntity>> messageMessage(
    MessageEntity messageEntity,
    String targetLanguage,
    int messageIndex,
  );
}
