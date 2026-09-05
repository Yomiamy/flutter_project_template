import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/bloc/bloc.dart';

import 'package:flutter_project_template/pages/play_list/widgets/widgets.dart';
import 'package:flutter_project_template/generated/l10n.dart';

import 'package:flutter_project_template/network/network.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).funday)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                GetPlayListBloc.dio(dio: DioProvider.dio)
                  ..add(const GetPlayListQuery(lang: 'zh-tw')),
          ),
          BlocProvider(create: (_) => DownloadBloc(dio: DioProvider.dio)),
        ],
        child: BlocListener<GetPlayListBloc, GetPlayListState>(
          listener: (context, state) {
            if (state.status == Status.success && state.playListItem != null) {
              context.read<DownloadBloc>().add(
                DownloadCheckStatus(items: state.playListItem!),
              );
            }
          },
          child: const PlayListView(),
        ),
      ),
    );
  }
}
