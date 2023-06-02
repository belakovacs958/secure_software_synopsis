

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/vendor_account_entity.dart';



@immutable
abstract class AccountState extends Equatable {}

class EmptyAccount extends AccountState {
  @override

  List<Object?> get props => [];
}

class LoadingAccount extends AccountState {
  @override

  List<Object?> get props => [];
}

class LoadedAccount extends AccountState {
  final AccountEntity account;

  LoadedAccount({required this.account});

  @override
  List<Object> get props => [account];
}

class ErrorAccount extends AccountState {
  ErrorAccount({required this.message});

  final String message;


  @override
  List<Object> get props => [message];

  @override

  int get hashCode => message.hashCode;

  @override

  bool operator == (Object other) => other is ErrorAccount && other.message  == message;

}
