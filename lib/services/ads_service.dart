import 'package:http/http.dart';
import 'base_api.dart';

class AdsService extends BaseAPI{
  Future<Response> getAdsPhoto()async{
    try {
      Response response = await get(Uri.parse(super.adsPath));
      return response;
    }catch(e){
      print(e.toString());
      return Response('', 404);
    }
  }
}