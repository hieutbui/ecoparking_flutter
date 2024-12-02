import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecoparking_flutter/data/network/dio_client.dart';
import 'package:ecoparking_flutter/di/base_di.dart';
import 'package:get_it/get_it.dart';

class NetworkDi extends BaseDi {
  static const acceptHeaderDefault = 'application/json';
  static const contentTypeHeaderDefault = 'application/json';
  static const serverDioName = 'serverDioName';
  static const serverDioClientName = 'serverDioClientName';

  @override
  void setUp(GetIt get) {
    _bindBaseOption(get);
    _bindInterceptor(get);
    _bindDio(get);
  }

  void _bindBaseOption(GetIt get) {
    final headers = {
      HttpHeaders.acceptHeader: acceptHeaderDefault,
      HttpHeaders.contentTypeHeader: contentTypeHeaderDefault,
    };
    get.registerLazySingleton<BaseOptions>(() => BaseOptions(headers: headers));
  }

  void _bindInterceptor(GetIt get) {}

  void _bindDio(GetIt get) {
    final baseOptions = get.get<BaseOptions>();
    get.registerLazySingleton<Dio>(
      () => Dio(baseOptions),
      instanceName: serverDioName,
    );
    get.registerLazySingleton<DioClient>(
      () => DioClient(get.get<Dio>(instanceName: serverDioName)),
      instanceName: serverDioClientName,
    );
  }
}
