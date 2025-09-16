part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesEvent {}

class FavoritesToggle extends FavoritesEvent {
  final int characterId;

  const FavoritesToggle(this.characterId);

  @override
  List<Object> get props => [characterId];
}

class FavoritesLoadCharacters extends FavoritesEvent {
  final List<String> favoriteIds;

  const FavoritesLoadCharacters(this.favoriteIds);

  @override
  List<Object> get props => [favoriteIds];
}
