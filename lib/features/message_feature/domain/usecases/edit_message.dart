import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';



class EditMessage implements UseCase<void, EditMessageParams> {
  final MessageRepository repository;

  EditMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(EditMessageParams params) async {
    return await repository.editMessage(params.messageEntity);
  }
}

class EditMessageParams extends Equatable {
  final MessageEntity messageEntity;

  EditMessageParams({required this.messageEntity});

  @override
  List<Object> get props => [messageEntity];
}
