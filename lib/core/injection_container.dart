import 'package:get_it/get_it.dart';
import 'package:mconnect_app/data/datasources/refresh_token_datasources.dart';
import 'package:mconnect_app/data/datasources/user_login_datasources.dart';
import 'package:mconnect_app/data/datasources/user_reg_datasources.dart';
import 'package:mconnect_app/data/repositories/refresh_token_repo_impl.dart';
import 'package:mconnect_app/data/repositories/user_login_repo_impl.dart';
import 'package:mconnect_app/data/repositories/user_reg_repo_impl.dart';
import 'package:mconnect_app/domain/repositories/refresh_token_repo.dart';
import 'package:mconnect_app/domain/repositories/user_login_repo.dart';
import 'package:mconnect_app/domain/repositories/user_reg_repo.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_login_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';

final GetIt sl = GetIt.instance;

void prepareSL() {
  sl.registerLazySingleton<UserLoginDataSource>(
      () => UserLoginDataSourceImpl());
  sl.registerLazySingleton<UserLoginRepo>(
      () => UserLoginRepoImpl(userLoginDataSource: sl()));
  sl.registerLazySingleton<UserLoginProvider>(
      () => UserLoginProvider(userLoginRepo: sl()));

  sl.registerLazySingleton<UserRegistrationDatasource>(
      () => UserRegistrationDatasourceImpl());
  sl.registerLazySingleton<UserRegistrationRepo>(
      () => UserRegistrationRepoImpl(userRegistrationDataSource: sl()));
  sl.registerLazySingleton<UserRegistrationProvider>(
      () => UserRegistrationProvider(userRegistrationRepo: sl()));

  sl.registerLazySingleton<TokenDatasource>(() => TokenDatasourceImpl());
  sl.registerLazySingleton<TokenRefreshRepo>(
      () => TokenRefreshRepoImpl(tokenDatasource: sl()));
  sl.registerLazySingleton<TokenRefreshProvider>(
      () => TokenRefreshProvider(tokenRefreshRepo: sl()));
}
