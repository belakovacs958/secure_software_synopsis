
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';


import 'features/account_feature/domain/usecases/get_user_info_use_case.dart';
import 'features/message_feature/data/datasources/message_remote_data_source.dart';
import 'features/message_feature/data/datasources/message_remote_data_source_impl.dart';
import 'features/message_feature/data/repositories/message_repository_impl.dart';
import 'features/message_feature/domain/repositories/message_repository.dart';
import 'features/message_feature/domain/usecases/create_message.dart';
import 'features/message_feature/domain/usecases/edit_message.dart';
import 'features/message_feature/domain/usecases/get_all_message.dart';
import 'features/message_feature/domain/usecases/get_message_by_id.dart';
import 'features/message_feature/presentation/bloc/message_bloc.dart';
import 'features/account_feature/data/datasources/vendor_account_remote_data_source.dart';
import 'features/account_feature/data/datasources/vendor_account_remote_data_source_impl.dart';
import 'features/account_feature/data/repositories/vendor_account_repository_impl.dart';
import 'features/account_feature/domain/repositories/vendor_account_repository.dart';
import 'features/account_feature/domain/usecases/edit_vendor_account_details_use_case.dart';
import 'features/account_feature/domain/usecases/facebook_login_use_case.dart';

import 'features/account_feature/domain/usecases/vendor_email_login_use_case.dart';
import 'features/account_feature/domain/usecases/vendor_email_register_use_case.dart';
import 'features/account_feature/domain/usecases/vendor_logout_use_case.dart';
import 'features/account_feature/presentation/bloc/vendor_account_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {




  // Bloc
  sl.registerFactory(() => AccountBloc(
    emailLogin: sl(),
    logout: sl(),
    register: sl(),
    editVendorAccountDetails: sl(),
    facebookLoginUseCase: sl(),
    getUserInfo: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => EmailLoginUseCase(sl()));
  sl.registerLazySingleton(() => VendorLogoutUseCase(sl()));
  sl.registerLazySingleton(() => VendorEmailRegisterUseCase(sl()));
  sl.registerLazySingleton(() => EditVendorAccountDetailsUseCase(sl()));
  sl.registerLazySingleton(() => FacebookLoginUseCase(sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(
      accountRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AccountRemoteDataSource>(
        () => VendorAccountRemoteDataSourceImpl(
      client: sl(),
    ),
  );


  //! Features Message Feature //////////// ////////// ////////// //////////// ////////// ////////// //////////// ////////// //////////
  // Bloc
  sl.registerFactory(() => MessageBloc(
    createMessage: sl(),
    editMessage: sl(),
    getAllMessages: sl(),
    getMessageById: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => CreateMessage(sl()));
  sl.registerLazySingleton(() => EditMessage(sl()));
  sl.registerLazySingleton(() => GetAllMessages(sl()));
  sl.registerLazySingleton(() => GetMessage(sl()));

  // Repositories
  sl.registerLazySingleton<MessageRepository>(
        () => MessageRepositoryImpl(messageRemoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MessageRemoteDataSource>(
        () => MessageRemoteDataSourceImpl(client: sl()),
  );









  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
}
