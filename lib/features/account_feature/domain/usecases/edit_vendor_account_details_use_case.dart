import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor_account_entity.dart';
import '../repositories/vendor_account_repository.dart';


class EditVendorAccountDetailsUseCase implements UseCase<void, EditVendorAccountDetailsParams> {
  final AccountRepository repository;

  EditVendorAccountDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(EditVendorAccountDetailsParams params) async {
    return await repository.editVendorAccountDetails(params.entity);
  }
}

class EditVendorAccountDetailsParams extends Equatable {
  final AccountEntity entity;

  EditVendorAccountDetailsParams({required this.entity});

  @override
  List<Object> get props => [entity];
}
