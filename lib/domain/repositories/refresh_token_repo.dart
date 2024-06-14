import 'package:mconnect_app/data/models/refresh_token_model.dart';

abstract class TokenRefreshRepo {
  Future<RefreshTokenDtos?> tokenRefresh();
}
