
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';

class GetMessage implements UseCase<MessageEntity, GetMessageParam> {
  late final MessageRepository repository;

  GetMessage(this.repository);

  @override
  Future<Either<Failure, MessageEntity>> call(
      GetMessageParam params) async {
    return await repository.messageMessage(
      params.messageEntity,
      params.targetLanguage,
      params.messageIndex,
    );

  }
}

class GetMessageParam extends Equatable {
  final MessageEntity messageEntity;
  final String targetLanguage;
  final int messageIndex;

  GetMessageParam({
    required this.messageEntity,
    required this.targetLanguage,
    required this.messageIndex,
  });

  @override
  List<Object> get props => [
        messageEntity,
        targetLanguage,
        messageIndex,
      ];
}
