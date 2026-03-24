import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/play_list/play_list.dart';
import 'package:flutter_home_work/bloc/status.dart';
import 'package:flutter_home_work/constants/sizes.dart';
import 'package:flutter_home_work/pages/play_list/widgets/widgets.dart';
import 'package:flutter_home_work/gen/colors.gen.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayListBloc, GetPlayListState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return const SizedBox.shrink();
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.failure:
            return Center(
              child: Text(
                state.errorMsg ?? 'Failed to load playlist',
                style: const TextStyle(color: ColorName.colorF44336),
              ),
            );
          case Status.success:
            final items = state.playListItem ?? [];
            if (items.isEmpty) {
              return const Center(child: Text('No playlist items found'));
            }

            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: Sizes.dividerXXXS,
                color: ColorName.color9e9e9e,
              ),
              itemBuilder: (context, index) {
                return PlayListTile(item: items[index], isPlay: index == 0);
              },
            );
        }
      },
    );
  }
}

