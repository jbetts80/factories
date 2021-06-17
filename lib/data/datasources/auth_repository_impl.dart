import 'package:factories/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _validUsername = 'jbetts80';
  final _validPassword = 'joeblack52';
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username == _validUsername && password == _validPassword) {
      return true;
    }
    return false;
  }
}
