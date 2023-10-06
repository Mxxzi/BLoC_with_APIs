part of 'bloc_bloc.dart';

@immutable
sealed class BlocState {}

abstract class PostActionState extends BlocState {}

final class BlocInitial extends BlocState {}

class PostsFetchingLoadingState extends BlocState {}

class PostsFetchingErrorState extends BlocState {}

class PostFetchingSucessfulState extends BlocState {
  final List<PostDataUiModel> posts;
  PostFetchingSucessfulState({required this.posts});

  get isVisible => null;
}

class PostsAdditionSuccessState extends BlocState {
  // final bool isVisible;
  // PostsAdditionSuccessState({required this.isVisible});
}

class PostsAdditionErrorState extends BlocState {}
