part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<String> favoriteIds;

  const FavoritesState(this.favoriteIds);

  bool isFavorite(int characterId) =>
      favoriteIds.contains(characterId.toString());

  @override
  List<Object> get props => [favoriteIds];
}
