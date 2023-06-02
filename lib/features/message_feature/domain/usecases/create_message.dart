import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/message_repository.dart';



class CreateMessage implements UseCase<void, CreateMessageParams> {
  final MessageRepository repository;

  CreateMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateMessageParams params) async {
    return await repository.createMessage(params.vendorEntity);
  }
}

class CreateMessageParams extends Equatable {
  final MessageEntity vendorEntity;

  CreateMessageParams({required this.vendorEntity});

  @override
  List<Object> get props => [vendorEntity];
}
