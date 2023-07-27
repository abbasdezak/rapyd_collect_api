import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_color.dart';
import 'package:rapyd_collect_api/core/app_style.dart';
import 'package:rapyd_collect_api/src/view/widget/bottom_bar.dart';
import 'package:rapyd_collect_api/src/view/screen/home_screen.dart';
import 'package:rapyd_collect_api/src/view/widget/empty_widget.dart';
import 'package:rapyd_collect_api/src/view/widget/counter_button.dart';
import 'package:rapyd_collect_api/src/view/widget/cart_list_view.dart';
import 'package:rapyd_collect_api/src/controller/office_furniture_controller.dart';

import 'cart_checkout_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Cart", style: h2Style),
      actions: [
        IconButton(
          splashRadius: 20.0,
          onPressed: controller.clearCart,
          icon: const Icon(Icons.delete, color: AppColor.lightBlack),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: Obx(
        () {
          return BottomBar(
            priceLabel: "Total price",
            priceValue: "\$${controller.totalPrice.value.toStringAsFixed(2)}",
            buttonLabel: "Checkout",
            onTap: controller.totalPrice > 0
                ? () {
                    Get.to(CartCheckoutPage());
                  }
                : null,
          );
        },
      ),
      body: GetBuilder(
        builder: (OfficeFurnitureController controller) {
          return controller.cartFurniture.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: CartListView(
                    furnitureItems: controller.cartFurniture,
                    counterButton: (furniture) {
                      return CounterButton(
                        orientation: Axis.vertical,
                        onIncrementSelected: () =>
                            controller.increaseItem(furniture),
                        onDecrementSelected: () =>
                            controller.decreaseItem(furniture),
                        label: furniture.quantity,
                      );
                    },
                  ),
                )
              : const EmptyWidget(title: "Empty");
        },
      ),
    );
  }
}
