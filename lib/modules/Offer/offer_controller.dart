import 'package:get/get.dart';
import '../../services/api_call_status.dart';
import '../../services/base_client.dart';
import '../../utils/constants.dart';
import '../Products/model/product_model.dart';

class OfferController extends GetxController {
  List<Product> offerModel = <Product>[];
  ApiCallStatus offerStatus = ApiCallStatus.holding;

  getOffer({IsLoad = true}) async {
    if (IsLoad) offerStatus = ApiCallStatus.loading;
    BaseClient.baseClient.post(Constants.productUrl, data: {
      "offer": 1,
    }, onSuccess: (response) {
      if (response.data['data'] != null) {
        offerModel = [];
        response.data['data'].forEach((v) {
          offerModel.add(Product.fromJson(v));
        });
      }
      offerStatus = ApiCallStatus.success;
      update(["offer"]);
    });
  }

  @override
  void onInit() {
    getOffer(IsLoad: true);
    super.onInit();
  }
}
