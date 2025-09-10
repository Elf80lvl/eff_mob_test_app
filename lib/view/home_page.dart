import 'dart:math';

import 'package:eff_mob_tes_app/data/const.dart';
import 'package:eff_mob_tes_app/logic/home_page/bloc/home_bloc_bloc.dart';
import 'package:eff_mob_tes_app/services/screen_helper.dart';
import 'package:eff_mob_tes_app/widgets/character_card.dart';
import 'package:eff_mob_tes_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<HomeBlocBloc>().add(const HomeBlocGetDataEvent(page: 1));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<HomeBlocBloc>();
    final state = bloc.state;
    //когда доходим до конца списка проверям есть ли след страница и загружаем если есть
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (state is HomeBlocLoaded && state.hasMore) {
        bloc.add(HomeBlocGetDataEvent(page: state.page + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is HomeBlocLoading && (state is! HomeBlocLoaded)) {
          return LoadingIndicator();
        } else if (state is HomeBlocError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is HomeBlocLoaded) {
          return Center(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ScreenHelper.isMobile(context)
                      ? double.infinity
                      : kMobileBreakpoint,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenHelper.isMobile(context)
                        ? kPaddingApp
                        : kPaddingApp * 2,
                    right: ScreenHelper.isMobile(context)
                        ? kPaddingApp
                        : kPaddingApp * 2,
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo is ScrollEndNotification) {
                        _onScroll();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 32),
                      itemCount:
                          state.characters.length + (state.hasMore ? 1 : 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ScreenHelper.isMobile(context) ? 2 : 4,
                      ),
                      itemBuilder: (context, index) {
                        if (index < state.characters.length) {
                          return CharacterCard(
                            character: state.characters[index],
                          );
                        } else {
                          return Center(child: LoadingIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text('Unknown error');
        }
      },
    );
  }
}
