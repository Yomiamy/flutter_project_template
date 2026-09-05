import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_project_template/data/paly_list/play_list_api.dart';

void main() {
  group('PlayListApi test group', () {
    late DioAdapter dioAdapter;
    late PlayListApi api;

    setUp(() {
      final dio = Dio();
      dioAdapter = DioAdapter(dio: dio, matcher: UrlRequestMatcher(matchMethod: true));
      api = PlayListApi(dio);
    });

    test('success case, get play list successfully', () async {
      const lang = 'zh-tw';
      const page = 1;
      const path = '/open-api/$lang/Media/Audio';

      dioAdapter.onGet(
        path,
        (server) => server.reply(
          HttpStatus.ok,
          jsonDecode(_Data.rspPlayList),
        ),
        queryParameters: {'page': page},
      );

      // 執行請求
      final rspPlayList = await api.getPlayList(lang, page);

      // 驗證解析結果
      expect(rspPlayList, isNotNull);
      expect(rspPlayList.total, 2);
      expect(rspPlayList.data, isNotNull);
      expect(rspPlayList.data!.length, 2);

      expect(rspPlayList.data![0].id, 28);
      expect(rspPlayList.data![0].title, "北投圖書館");

      expect(rspPlayList.data![1].id, 27);
      expect(rspPlayList.data![1].title, "臺北市立動物園");
    });
  });
}

class _Data {
  static const String rspPlayList = """
{
  "total": 2,
  "data": [
    {
      "id": 28,
      "title": "北投圖書館",
      "summary": null,
      "url": "https://www.travel.taipei/audio/28",
      "file_ext": null,
      "modified": "2025-12-10 15:55:41 +08:00"
    },
    {
      "id": 27,
      "title": "臺北市立動物園",
      "summary": null,
      "url": "https://www.travel.taipei/audio/27",
      "file_ext": null,
      "modified": "2024-11-15 13:35:09 +08:00"
    }
  ]
}
""";
}
