import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'features/item/presentation/providers/item_provider.dart';
import 'features/item/domain/repositories/item_repository.dart';
import 'features/item/data/repositories/item_repository_impl.dart';
import 'features/item/data/api/item_api.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupServiceLocator();
    runApp(const MyApp());
  } catch (e, stackTrace) {
    print('Error during initialization: $e');
    print('Stack trace: $stackTrace');
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error: $e'),
          ),
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemProvider(
            ItemRepositoryImpl(
              ItemApi(baseUrl: 'http://localhost:3000/api'),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'UNI Lost & Found',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
