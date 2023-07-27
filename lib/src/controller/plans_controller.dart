import 'package:get/get.dart';
import 'package:rapyd_collect_api/core/models/plan.dart';
import 'package:rapyd_collect_api/core/utils/rapyd_client_api.dart';
import 'package:rapyd_collect_api/core/utils/rapyd_client_api_impl.dart';

class PlansController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final planDetails = <Plan>[].obs;
  final loadingStatus = LoadingStatus.init.obs;
  final RapydClientApi rapyd = RapydClientApiImpl();

  @override
  void onInit() async {
    print('initiated on init');

    await loadPlanIds();

    super.onInit();
  }

  loadPlanIds() async {
    loadingStatus(LoadingStatus.loading);

    try {
      final plans = await rapyd.getPlans();

// Getting product details
      for (var plan in plans) {
        print('plan product:\n${plan.product}');
        print('plan nickname:\n${plan.nickname}');
        final result = await rapyd.getPlanDetails(plan.id!);

        planDetails.add(result);
      }

      loadingStatus(LoadingStatus.success);
    } on Exception catch (e) {
      loadingStatus(LoadingStatus.failure);
    }
  }
}

enum LoadingStatus { init, loading, failure, success }
