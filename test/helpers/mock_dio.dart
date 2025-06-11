import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#get, [path], {
        #queryParameters: queryParameters,
        #options: options,
        #cancelToken: cancelToken,
        #onReceiveProgress: onReceiveProgress,
      }),
      returnValue: Response<T>(
        data: null as T,
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      ),
    ) as Future<Response<T>>;
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#post, [path], {
        #data: data,
        #queryParameters: queryParameters,
        #options: options,
        #cancelToken: cancelToken,
        #onSendProgress: onSendProgress,
        #onReceiveProgress: onReceiveProgress,
      }),
      returnValue: Response<T>(
        data: null as T,
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      ),
    ) as Future<Response<T>>;
  }
} 