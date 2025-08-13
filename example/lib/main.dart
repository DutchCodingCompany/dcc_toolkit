import 'package:dcc_toolkit/ui/annotated_text/annotated_text.dart';
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: AnnotatedText(
                text:
                    '[Flutter](onFlutterTap) example of using a Rich Text with annotations with multiple [tap](onTap) actions.\nThis tap [action](action) does nothing. And [action] without () does nothing as well',
                defaultStyle: const TextStyle(color: Colors.black),
                annotationStyle: const TextStyle(color: Colors.blue),
                actions: {
                  'onFlutterTap':
                      () =>
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(content: Text('Flutter')),
                            ),
                  'onTap':
                      () =>
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(content: Text('Tap')),
                            ),
                },
              ),
            ),
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
