
import '../../domain/entities/vendor_account_entity.dart';

class AdminAccountModel extends AccountEntity {
  AdminAccountModel({
    required String adminDisplayName,
    required String uid,
    required String email,

  }) : super(
          adminDisplayName: adminDisplayName,
          uid: uid,
          email: email,

        );

  factory AdminAccountModel.fromJson(Map<String, dynamic> json) {
    return AdminAccountModel(
      adminDisplayName: json['username'],
      uid: json['uid'],
      email: json['email'],

    );
  }

/*
  Map<String, dynamic> toJson() {
    return {

      }
    };
  }

   */
}
