import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {

  final String adminDisplayName;
  final String uid;
  final String email;

  AccountEntity({
    required this.adminDisplayName,
    required this.uid,
    required this.email,
  });

  @override
  List<Object?> get props => [
        adminDisplayName,
        email,
        uid,
      ];
}
