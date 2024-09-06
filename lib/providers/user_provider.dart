import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/models/user_model.dart';
import 'package:loginapp/providers/api_provider.dart';
import 'package:loginapp/providers/auth_provider.dart';

class UserProvider extends StateNotifier<UserModel> {
  UserProvider(this.ref) : super(UserModel());
  final Ref ref;

  Future<UserModel> user() async {
    final dio = ref.read(apiProvider.notifier).apiURL();
    final token = await ref.read(authProvider.notifier).getToken();

    try {
      final response = await dio.get('user/show',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        final Map<String, dynamic> mapData = response.data["user"];
        state = UserModel.fromJson(mapData);
        return state;
      } else {
        throw Exception('Bir hata oluştu');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, UserModel>((ref) => UserProvider(ref));
