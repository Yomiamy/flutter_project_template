import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/bloc/bloc.dart';
import 'package:flutter_project_template/constants/constants.dart';
import 'package:flutter_project_template/pages/play_list/widgets/widgets.dart';
import 'package:flutter_project_template/gen/colors.gen.dart';
import 'package:flutter_project_template/generated/l10n.dart';

class PlayListView extends StatefulWidget {
  const PlayListView({super.key});

  @override
  State<PlayListView> createState() => _PlayListViewState();
}

class _PlayListViewState extends State<PlayListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 200) {
      final state = context.read<GetPlayListBloc>().state;
      if (!state.status.isLoading && state.hasMore) {
        context.read<GetPlayListBloc>().add(
              const GetPlayListQuery(
                lang: 'zh-tw',
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayListBloc, GetPlayListState>(
      builder: (context, state) {
        final items = state.playListItem ?? [];

        if (state.status.isLoading && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isFailure && items.isEmpty) {
          return Center(
            child: Text(
              state.errorMsg ?? S.of(context).load_failed,
              style: const TextStyle(color: ColorName.colorF44336),
            ),
          );
        }

        if (items.isEmpty) {
          return Center(child: Text(S.of(context).no_data));
        }

        return ListView.separated(
          controller: _scrollController,
          itemCount: items.length + 1,
          separatorBuilder: (context, index) => const Divider(
            thickness: Sizes.dividerXXXS,
            color: ColorName.color9e9e9e,
          ),
          itemBuilder: (context, index) {
            if (index == items.length) {
              return const _BottomIndicator();
            }
            return PlayListTile(item: items[index]);
          },
        );
      },
    );
  }
}

class _BottomIndicator extends StatelessWidget {
  const _BottomIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayListBloc, GetPlayListState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(Sizes.paddingL),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!state.hasMore) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.paddingL),
            child: Center(
              child: Text(
                S.of(context).no_more_data,
                style: const TextStyle(
                  color: ColorName.color9e9e9e,
                  fontSize: Sizes.fontSizeS,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
