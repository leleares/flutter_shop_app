import 'package:flutter_shop_app/constants/index.dart';
import 'package:flutter_shop_app/utils/DioRequest.dart';
import 'package:flutter_shop_app/viewmodels/mine.dart';

Future<GuessYouLikeGoodsResp> getGuessYouLikeGoodsResult(
  Map<String, dynamic> params,
) async {
  Map<String, dynamic> result = await dioRequest.get(
    HttpConstants.GUESS_YOU_LIKE,
    params: params,
  );

  GuessYouLikeGoodsResp guessYouLikeGoodsResp = GuessYouLikeGoodsResp.fromJSON(
    result,
  );

  return guessYouLikeGoodsResp;
}
