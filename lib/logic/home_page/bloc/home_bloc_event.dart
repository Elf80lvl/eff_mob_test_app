part of 'home_bloc_bloc.dart';

sealed class HomeBlocEvent extends Equatable {
  const HomeBlocEvent();

  @override
  List<Object> get props => [];
}

final class HomeBlocGetDataEvent extends HomeBlocEvent {
  final int page;
  const HomeBlocGetDataEvent({this.page = 1});

  @override
  List<Object> get props => [page];
}
