import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/api/auth_api.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/item/data/repositories/item_repository_impl.dart';
import '../../features/item/domain/repositories/item_repository.dart';
import '../../features/item/data/api/item_api.dart';
import '../../features/profile/data/api/profile_api.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/providers/profile_provider.dart';
import '../../features/item/presentation/providers/item_provider.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // External
    final sharedPreferences = await SharedPreferences.getInstance();
    serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

    // Dio
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:5000/api', // Use 10.0.2.2 for Android emulator to access localhost
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor in debug mode
    assert(() {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
      return true;
    }());

    serviceLocator.registerSingleton<Dio>(dio);

    // API
    serviceLocator.registerLazySingleton<AuthApi>(() => AuthApi(serviceLocator<Dio>()));
    serviceLocator.registerLazySingleton<ItemApi>(() => ItemApi(baseUrl: 'http://your-api-url.com/api'));
    serviceLocator.registerLazySingleton<ProfileApi>(() => ProfileApi(serviceLocator<Dio>()));

    // Repositories
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthApi>(),
        serviceLocator<SharedPreferences>(),
      ),
    );
    serviceLocator.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(serviceLocator<ItemApi>()),
    );
    serviceLocator.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator<ProfileApi>()),
    );

    // Providers
    serviceLocator.registerFactory<ProfileProvider>(
      () => ProfileProvider(serviceLocator<ProfileRepository>()),
    );
    serviceLocator.registerFactory<ItemProvider>(
      () => ItemProvider(serviceLocator<ItemRepository>()),
    );

    // Restore auth token if user is logged in
    try {
      final authRepository = serviceLocator<AuthRepository>();
      final currentUser = (authRepository as AuthRepositoryImpl).getCurrentUser();
      if (currentUser != null) {
        serviceLocator<AuthApi>().setAuthToken(currentUser.token);
      }
    } catch (e) {
      print('Error restoring auth token: $e');
      // Continue without restoring the token
    }
  } catch (e, stackTrace) {
    print('Error in setupServiceLocator: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 