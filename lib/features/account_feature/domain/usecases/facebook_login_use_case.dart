import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor_account_entity.dart';
import '../repositories/vendor_account_repository.dart';


class FacebookLoginUseCase implements UseCase<AccountEntity, NoParams> {
  final AccountRepository repository;
  FacebookLoginUseCase(this.repository);



  @override
  Future<Either<Failure, AccountEntity>> call(NoParams params) async {
   return await repository.facebookLogin();
  }

}







