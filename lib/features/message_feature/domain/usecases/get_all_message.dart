import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';



class GetAllMessages implements UseCase<List<MessageEntity>, NoParams> {
  final MessageRepository repository;

  GetAllMessages(this.repository);

  @override
  Future<Either<Failure, List<MessageEntity>>> call(NoParams params) async {
    return await repository.getAllMessages();
  }
}



