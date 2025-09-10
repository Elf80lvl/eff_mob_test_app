part of 'home_bloc_bloc.dart';

sealed class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

final class HomeBlocInitial extends HomeBlocState {}

final class HomeBlocLoading extends HomeBlocState {}

final class HomeBlocLoaded extends HomeBlocState {
  final List<Character> characters;
  final int page;
  final bool hasMore;
  const HomeBlocLoaded({
    required this.characters,
    required this.page,
    required this.hasMore,
  });
  @override
  List<Object> get props => [characters, page, hasMore];
}

final class HomeBlocError extends HomeBlocState {
  final String message;
  const HomeBlocError({required this.message});
  @override
  List<Object> get props => [message];
}
