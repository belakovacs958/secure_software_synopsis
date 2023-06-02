import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/vendor_account_entity.dart';

@immutable
abstract class VendorAccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VendorEmailLoginEvent extends VendorAccountEvent {
  VendorEmailLoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class VendorEmailRegisterEvent extends VendorAccountEvent {
  VendorEmailRegisterEvent({
    required this.vendorAccountEntity,
    required this.password,
  });

  final AccountEntity vendorAccountEntity;
  final String password;

  @override
  List<Object> get props => [vendorAccountEntity, password];
}

class DeleteVendorAccountEvent extends VendorAccountEvent {
  DeleteVendorAccountEvent({
    required this.vendorAccountEntity,
  });

  final AccountEntity vendorAccountEntity;

  @override
  List<Object> get props => [vendorAccountEntity];
}

class FacebookLoginEvent extends VendorAccountEvent {}

class VendorLogoutEvent extends VendorAccountEvent {}

class GetUserInfoEvent extends VendorAccountEvent {
  GetUserInfoEvent({required this.uid});

  final String uid;

  @override
  List<Object> get props => [uid];
}
