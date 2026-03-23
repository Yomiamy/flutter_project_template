import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/play_list/play_list.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlayListBloc, GetPlayListState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}