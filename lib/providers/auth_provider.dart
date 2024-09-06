import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/providers/api_provider.dart';
import 'package:loginapp/providers/screen_providers.dart';


class AuthProvider extends StateNotifier<bool> {
  AuthProvider(this.ref) : super(false);
  final Ref ref;

  Future<bool> login(String email, String password) async {
    final dio = ref.read(apiProvider.notifier).apiURL();

    try {
      final response = await dio.post(
        'user/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        final secureStorage = ref.read(secureStorageProivder);
        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(
            key: 'user', value: jsonEncode(response.data['data']));
        ref.read(loginLoadingProvider.notifier).state = false;
        return true;
      } else {
        ref.read(loginLoadingProvider.notifier).state = false;
        return false;
      }
    } catch (e) {
      ref.read(loginLoadingProvider.notifier).state = false;

      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    final dio = ref.read(apiProvider.notifier).apiURL();
    try {
      final response = await dio.post(
        'user/register',
        data: {
          'fname': name,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        ref.read(registerLoadingProvider.notifier).state = false;
        return true;
      } else {
        ref.read(registerLoadingProvider.notifier).state = false;
        return false;
      }
    } catch (e) {
      ref.read(registerLoadingProvider.notifier).state = false;
      return false;
    }
  }

  Future<String?> getToken() async {
    final secureStorage = ref.read(secureStorageProivder);
    return await secureStorage.read(key: 'token');
  }

  Future<bool> logout() async {
    final secureStorage = ref.read(secureStorageProivder);
    await secureStorage.delete(key: 'token');
    return true;
  }
}

final authProvider = StateNotifierProvider<AuthProvider, bool>((ref) {
  return AuthProvider(ref);
});
