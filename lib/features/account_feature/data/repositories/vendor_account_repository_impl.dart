import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/vendor_account_entity.dart';
import '../../domain/repositories/vendor_account_repository.dart';
import '../datasources/vendor_account_remote_data_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;


  AccountRepositoryImpl({
    required this.accountRemoteDataSource,

  });

  @override
  Future<Either<Failure, void>> editVendorAccountDetails(
      AccountEntity vendorAccountEntity) async {
    try {
      await accountRemoteDataSource.sendEditVendorAccountDetails(vendorAccountEntity);
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> emailLogin(
      String email, String password) async {
    try {
      AccountEntity accountEntity = await accountRemoteDataSource.loginWithEmail(email, password);
      return Right(accountEntity);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> vendorLogout() async {
    try {
      await accountRemoteDataSource.sendVendorLogout();
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> vendorEmailRegister(
      AccountEntity vendorAccountEntity, String password) async {
    try {
      AccountEntity accountEntity =  await accountRemoteDataSource.registerWithEmail(
          vendorAccountEntity, password);
      return Right(accountEntity);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> facebookLogin() async {
    try {
      AccountEntity accountEntity = await accountRemoteDataSource.facebookLogin();
      return Right(accountEntity);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, AccountEntity>> getUserInfo(
      String uid) async {
    try {
      AccountEntity accountEntity = await accountRemoteDataSource.getUserInfo(uid);
      return Right(accountEntity);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }
}
