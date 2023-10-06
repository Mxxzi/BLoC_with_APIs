import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_with_apis/features/posts/models/post_data_ui_model.dart';
import 'package:flutter_bloc_with_apis/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }
  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<BlocState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchingSucessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<BlocState> emit) async {
    bool success = await PostsRepo.addPosts();
    print(success);
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}
