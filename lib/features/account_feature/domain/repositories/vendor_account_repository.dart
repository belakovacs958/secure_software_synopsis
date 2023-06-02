import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vendor_account_entity.dart';

abstract class AccountRepository {
  Future<Either<Failure, AccountEntity>> emailLogin(String email, String password);
  Future<Either<Failure, AccountEntity>> vendorEmailRegister(AccountEntity vendorAccountEntity, String password);
  Future<Either<Failure, void>> editVendorAccountDetails(AccountEntity vendorAccountEntity);
  Future<Either<Failure, void>> vendorLogout();
  Future<Either<Failure, AccountEntity>> facebookLogin();
  Future<Either<Failure, AccountEntity>> getUserInfo(String uid);

}