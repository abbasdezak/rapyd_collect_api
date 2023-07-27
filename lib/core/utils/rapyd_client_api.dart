import 'package:rapyd_collect_api/core/models/plan.dart';

abstract class RapydClientApi {
  Future<List<Plan>> getPlans();
  Future<Plan> getPlanDetails(String planId);
  Future<Map> subscribeToPlan(String planId);
  Future<Map> checkout(String price);
}
