import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_with_apis/features/posts/bloc/bloc_bloc.dart';
import 'package:flutter_bloc_with_apis/features/posts/ui/posts_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BlocBloc(),
        child: const PostsPage(),
      ),
    );
  }
}
