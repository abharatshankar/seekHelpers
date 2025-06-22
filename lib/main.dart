import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/presentation/providers/user_provider.dart';
import 'features/user/presentation/screens/home_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  final userRemoteDataSource = UserRemoteDataSourceImpl(client: http.Client());
  final userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  final getUsersUsecase = GetUsers(userRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(getUsersUsecase: getUsersUsecase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Directory (Clean Architecture)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
