import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor_account_entity.dart';
import '../repositories/vendor_account_repository.dart';

class GetUserInfoUseCase
    implements UseCase<AccountEntity, GetUserInfoUseCaseParams> {
  final AccountRepository repository;

  /// this is the [GetUserInfoUseCaseUseCase] class

  GetUserInfoUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(
      GetUserInfoUseCaseParams params) async {
    return await repository.getUserInfo(params.uid);
  }
}

class GetUserInfoUseCaseParams extends Equatable {
  GetUserInfoUseCaseParams({
    required this.uid,
  });

  final String uid;

  @override
  List<Object> get props => [
        uid,
      ];
}
