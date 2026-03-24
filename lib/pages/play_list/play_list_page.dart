import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/bloc.dart';
import 'package:flutter_home_work/network/interceptors/log_interceptor.dart';
import 'package:flutter_home_work/pages/play_list/widgets/widgets.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://www.travel.taipei',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  ),
)..interceptors.add(LoggerInterceptor());

class PlayListPage extends StatelessWidget {
  const PlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Funday')),
      body: BlocProvider(
        create: (_) => GetPlayListBloc.dio(
              dio: dio,
            ),
          )..interceptors.add(LoggerInterceptor()),
        )..add(GetPlayListQuery(page: 1, lang: 'zh-tw')),
        child: const PlayListView(),
      ),
    );
  }
}
