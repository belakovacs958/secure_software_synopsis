import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor_account_entity.dart';
import '../repositories/vendor_account_repository.dart';

class VendorEmailRegisterUseCase
    implements UseCase<AccountEntity, VendorEmailRegisterParams> {
  final AccountRepository repository;

  /// this is the [VendorEmailRegisterUseCase] class

  VendorEmailRegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AccountEntity>> call(VendorEmailRegisterParams params) async {
    return await repository.vendorEmailRegister(params.vendorAccountEntity, params.password);
  }
}

class VendorEmailRegisterParams extends Equatable {
  final AccountEntity vendorAccountEntity;
  final String password;


  VendorEmailRegisterParams({
    required this.vendorAccountEntity,
    required this.password,

  });

  @override
  List<Object> get props => [
        vendorAccountEntity,
        password,

      ];
}
