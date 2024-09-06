
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loginapp/constants/path.dart';

final secureStorageProivder = Provider((ref) => const FlutterSecureStorage());


class ApiProvider extends StateNotifier<Dio> {
  ApiProvider(this.ref) : super(Dio());
  final Ref ref;

  Dio apiURL() {
    return Dio(BaseOptions(baseUrl: Paths.apiURL));
  }
}

final apiProvider =
    StateNotifierProvider<ApiProvider, Dio>((ref) => ApiProvider(ref));