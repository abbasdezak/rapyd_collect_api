import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/src/controller/plans_controller.dart';
import 'package:rapyd_collect_api/src/view/widget/plan_card.dart';

import 'subscription_checkout_page.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final controller = Get.put(PlansController());
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: Get.width * .98);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: _renderBody(),
      );
    });
  }

  Widget _renderBody() {
    switch (controller.loadingStatus.value) {
      case LoadingStatus.failure:
        return const Center(
          child: Text('Failed to retrieve plans\nCheck your connection '),
        );
      case LoadingStatus.success:
        return _planLists();
      case LoadingStatus.init:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  ListView _planLists() {
    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        final plan = controller.planDetails[index];
        return PlanCard(
            title: plan.product!.name!,
            subTitle: plan.amount!,
            details: plan.product!.description!,
            onTap: () {
              final result = Get.to(SubscriptionCheckoutPage(
                planId: plan.id!,
              ));
              print(result);
            });
      },
      itemCount: controller.planDetails.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
