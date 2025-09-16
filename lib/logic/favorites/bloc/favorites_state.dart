part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesStateInitial extends FavoritesState {
  const FavoritesStateInitial();
}

class FavoritesStateLoading extends FavoritesState {
  const FavoritesStateLoading();
}

class FavoritesStateLoaded extends FavoritesState {
  final List<String> favoriteIds;
  final List<Character> characters;

  const FavoritesStateLoaded({
    required this.favoriteIds,
    required this.characters,
  });

  bool isFavorite(int characterId) =>
      favoriteIds.contains(characterId.toString());

  @override
  List<Object> get props => [favoriteIds, characters];
}

class FavoritesStateError extends FavoritesState {
  final String message;

  const FavoritesStateError(this.message);

  @override
  List<Object> get props => [message];
}
