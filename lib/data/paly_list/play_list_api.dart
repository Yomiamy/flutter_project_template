import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/rsp_play_list.dart';

part 'play_list_api.g.dart';

@RestApi()
abstract class PlayListApi {
  factory PlayListApi(Dio dio) = _PlayListApi;

  /// 取得語音導覽播放清單
  @GET('/open-api/{lang}/Media/Audio')
  Future<RspPlayList> getPlayList(
    @Path('lang') String lang,
    @Query('page') int page,
  );
}
