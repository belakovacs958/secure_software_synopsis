import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor_account_entity.dart';
import '../repositories/vendor_account_repository.dart';

class EmailLoginUseCase implements UseCase<AccountEntity, VendorLoginParams> {
  final AccountRepository repository;

  /// this is the [EmailLoginUseCase] class

  EmailLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(VendorLoginParams params) async {
    return await repository.emailLogin(params.email, params.password);
  }
}

class VendorLoginParams extends Equatable {
   VendorLoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
