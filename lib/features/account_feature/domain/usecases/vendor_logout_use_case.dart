import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/vendor_account_repository.dart';


class VendorLogoutUseCase implements UseCase<void, NoParams> {
  final AccountRepository repository;

  /// this is the [VendorLogoutUseCase] class

  VendorLogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.vendorLogout();
  }
}
