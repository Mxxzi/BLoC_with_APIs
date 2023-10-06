import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_with_apis/features/posts/bloc/bloc_bloc.dart';
import 'package:flutter_bloc_with_apis/features/posts/repos/posts_repo.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  bool dataLoaded = true;
  final BlocBloc blocBloc = BlocBloc();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    blocBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          final isSuccess = await PostsRepo.addPosts();
          if (isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Post added successfully.",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Failed to add the post.",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
          // if (dataLoaded) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Post added successfully."),
          //       duration: Duration(seconds: 2),
          //     ),
          //   );
          // blocBloc.add(PostAddEvent());
          // }
        },
      ),
      body: BlocConsumer<BlocBloc, BlocState>(
        bloc: blocBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSucessfulState:
              final successState = state as PostFetchingSucessfulState;

              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            successState.posts[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            successState.posts[index].body,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Set the duration as needed
      ),
    );
  }
}
