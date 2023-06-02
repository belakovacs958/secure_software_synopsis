

import '../../domain/entities/vendor_account_entity.dart';

abstract class AccountRemoteDataSource {

  /// Accesses a remote data source

  Future<AccountEntity> loginWithEmail(String email, String password);
  Future<AccountEntity> registerWithEmail(AccountEntity vendorAccountEntity, String password,);
  Future<void> sendEditVendorAccountDetails(AccountEntity vendorAccountEntity);
  Future<void> sendVendorLogout();
  Future<AccountEntity> facebookLogin();
  Future<AccountEntity> getUserInfo(String uid);
}