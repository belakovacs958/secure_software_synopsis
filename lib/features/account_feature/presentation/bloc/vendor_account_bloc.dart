import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../utils/failure_messages.dart';
import '../../domain/entities/vendor_account_entity.dart';
import '../../domain/usecases/edit_vendor_account_details_use_case.dart';
import '../../domain/usecases/facebook_login_use_case.dart';
import '../../domain/usecases/get_user_info_use_case.dart';
import '../../domain/usecases/vendor_email_login_use_case.dart';
import '../../domain/usecases/vendor_email_register_use_case.dart';
import '../../domain/usecases/vendor_logout_use_case.dart';
import 'vendor_account_event.dart';
import 'vendor_account_state.dart';

class AccountBloc extends Bloc<VendorAccountEvent, AccountState> {
  AccountBloc({
    required EmailLoginUseCase emailLogin,
    required VendorLogoutUseCase logout,
    required VendorEmailRegisterUseCase register,
    required EditVendorAccountDetailsUseCase editVendorAccountDetails,
    required FacebookLoginUseCase facebookLoginUseCase,
    required GetUserInfoUseCase getUserInfo,
  })  : emailLogin = emailLogin,
        logout = logout,
        editVendorAccountDetails = editVendorAccountDetails,
        emailRegister = register,
        facebookLoginUseCase = facebookLoginUseCase,
        getUserInfo = getUserInfo,
        super(EmptyAccount()) {
    on<VendorEmailLoginEvent>(_onEmailLoginEvent);
    on<VendorLogoutEvent>(_onLogoutEvent);
    on<VendorEmailRegisterEvent>(_onEmailRegisterEvent);
    on<DeleteVendorAccountEvent>(_onDeleteAccountEvent);
    on<FacebookLoginEvent>(_onFacebookLoginEvent);
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
  }

  EmailLoginUseCase emailLogin;
  VendorEmailRegisterUseCase emailRegister;
  EditVendorAccountDetailsUseCase editVendorAccountDetails;
  VendorLogoutUseCase logout;
  FacebookLoginUseCase facebookLoginUseCase;
  GetUserInfoUseCase getUserInfo;

  Future<void> _onEmailLoginEvent(
    VendorEmailLoginEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case VendorEmailLoginEvent:
        emit(LoadingAccount());
        Either<Failure, AccountEntity> response = await emailLogin.call(
            VendorLoginParams(email: event.email, password: event.password));
        return emit(
          await response.fold(
            (failure) async {

              return ErrorAccount(message: mapFailureToMessage(failure));
            },
            (user) async {

              return LoadedAccount(account: user);
            },
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

  void _onLogoutEvent(
    VendorLogoutEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case VendorLogoutEvent:
        emit(LoadingAccount());
        Either<Failure, void> response = await logout.call(NoParams());
        return emit(
          await response.fold(
            (failure) =>
                ErrorAccount(message: mapFailureToMessage(failure)),
            (user) => EmptyAccount(),
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

  void _onEmailRegisterEvent(
    VendorEmailRegisterEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case VendorEmailRegisterEvent:
        emit(LoadingAccount());
        Either<Failure, AccountEntity> response = await emailRegister.call(
            VendorEmailRegisterParams(
                password: event.password,
                vendorAccountEntity: event.vendorAccountEntity));
        return emit(
          await response.fold(
            (failure) async {

              return ErrorAccount(message: mapFailureToMessage(failure));
            },
            (user) async {
              return LoadedAccount(account: user);
            },
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

  void _onDeleteAccountEvent(
    DeleteVendorAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case DeleteVendorAccountEvent:
        emit(LoadingAccount());
        Either<Failure, void> response = await editVendorAccountDetails.call(EditVendorAccountDetailsParams(entity: event.vendorAccountEntity));
        return emit(
          await response.fold(
                (failure) =>
                ErrorAccount(message: mapFailureToMessage(failure)),
                (user) => EmptyAccount(),
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

  void _onFacebookLoginEvent(
    FacebookLoginEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case FacebookLoginEvent:
        emit(LoadingAccount());
        Either<Failure, AccountEntity> response =
            await facebookLoginUseCase.call(NoParams());
        return emit(
          await response.fold(
            (failure) async {
              return ErrorAccount(message: mapFailureToMessage(failure));
            },
            (user) async {

              return LoadedAccount(account: user);
            },
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

  Future<void> _onGetUserInfoEvent(
    GetUserInfoEvent event,
    Emitter<AccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case GetUserInfoEvent:
        emit(LoadingAccount());
        Either<Failure, AccountEntity> response =
            await getUserInfo.call(GetUserInfoUseCaseParams(uid: event.uid));
        return emit(
          await response.fold(
            (failure) =>
                ErrorAccount(message: mapFailureToMessage(failure)),
            (user) => LoadedAccount(account: user),
          ),
        );
      default:
        return emit(EmptyAccount());
    }
  }

/*
  void _onLoginEvent(
    VendorLoginEvent event,
    Emitter<VendorAccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case VendorLoginEvent:
        emit(LoadingVendorAccount());
        Either<Failure, UserEntity> userState = await login
            .call(Params(email: event.email, password: event.password));
        return emit(
          await userState.fold(
            (failure) =>
                ErrorVendorAccount(message: _mapFailureToMessage(failure)),
            (user) => LoadedVendorAccount(vendorAccount: user),
          ),
        );
      default:
        return emit(EmptyVendorAccount());
    }
  }

  void _onLogoutEvent(
    VendorLogoutEvent event,
    Emitter<VendorAccountState> emit,
  ) async {
    switch (event.runtimeType) {
      case VendorLogoutEvent:
        emit(LoadingVendorAccount());
        Either<Failure, void> userState = await logout.call(NoParams());
        return emit(
          await userState.fold(
            (failure) =>
                ErrorVendorAccount(message: _mapFailureToMessage(failure)),
            (user) => EmptyVendorAccount(),
          ),
        );
      default:
        return emit(EmptyVendorAccount());
    }
  }


   */
}
