part of 'bloc_bloc.dart';

@immutable
sealed class BlocEvent {}

class PostsInitialFetchEvent extends BlocEvent {}

class PostAddEvent extends BlocEvent {
  // final String userId;
  // final String title;

  // PostAddEvent({required this.userId, required this.title});
}

// class UpdateUserIdEvent extends BlocEvent {
//   final String userId;

//   UpdateUserIdEvent(this.userId);
// }

// class UpdateTitleEvent extends BlocEvent {
//   final String title;

//   UpdateTitleEvent(this.title);
// }
