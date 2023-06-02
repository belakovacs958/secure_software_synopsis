import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../message_feature/domain/entities/message_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';



class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl({
    required this.messageRemoteDataSource,
  });

  final MessageRemoteDataSource messageRemoteDataSource;

  @override
  Future<Either<Failure, void>> createMessage(MessageEntity message) async {
    try {
      await messageRemoteDataSource.createMessage(message);
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editMessage(MessageEntity message) async {
    try {
      await messageRemoteDataSource.editMessage(message);
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }


  @override
  Future<Either<Failure, List<MessageEntity>>> getAllMessages() async {
    try {
      List<MessageEntity> messages = await messageRemoteDataSource.getAllMessages();
      return Right(messages);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> messageMessage(  MessageEntity messageEntity,
      String targetLanguage,
      int messageIndex,) async {
    try {
      MessageEntity messagedMessage = await messageRemoteDataSource.getMessage(messageEntity,targetLanguage,messageIndex);
      return Right(messagedMessage);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }
}
