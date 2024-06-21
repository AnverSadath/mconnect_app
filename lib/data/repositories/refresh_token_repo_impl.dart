import 'package:mconnect_app/data/datasources/refresh_token_datasources.dart';
import 'package:mconnect_app/data/models/refresh_token_model.dart';
import 'package:mconnect_app/domain/repositories/refresh_token_repo.dart';

class TokenRefreshRepoImpl extends TokenRefreshRepo {
  TokenDatasource tokenDatasource;

  TokenRefreshRepoImpl({required this.tokenDatasource});

  @override
  Future<RefreshTokenDtos?> tokenRefresh() async {
    try {
      return await tokenDatasource.tokenRefresh();
    } catch (e) {
      print(" error loging user:$e");
      throw (e);
    }
  }

  bool isTokenExpired(String? tokenExpiry) {
    return tokenDatasource.isTokenExpired(tokenExpiry);
  }
}
