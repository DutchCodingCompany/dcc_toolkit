import 'package:example/core/injectable/injectable.dart';
import 'package:example/profile/presentation/cubit/user_cubit.dart';
import 'package:example/profile/presentation/user_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => UserPage(
                            onCreateCubit:
                                (context) =>
                                    getIt<UserCubit>()..getRandomUser(),
                          ),
                    ),
                  ),
              child: const Text('Get user succesfully'),
            ),
            ElevatedButton(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => UserPage(
                            onCreateCubit:
                                (context) =>
                                    getIt<UserCubit>()..getRandomUserFails(),
                          ),
                    ),
                  ),
              child: const Text('Get user fails'),
            ),
          ],
        ),
      ),
    );
  }
}
