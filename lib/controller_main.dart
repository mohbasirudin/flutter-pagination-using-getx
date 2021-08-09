import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pagination/api_service.dart';
import 'package:getx_pagination/model_test.dart';

class BindingMain extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerMain());
  }
}

class ControllerMain extends GetxController {
  RxList<ModelTest> data = <ModelTest>[].obs;
  RxInt _curUserId = 1.obs;
  RxInt _lastUserId = 10.obs;
  RxBool max = false.obs;
  RxBool loadMore = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(() => _onScroll());
    getData();
    super.onInit();
  }

  _onScroll() {
    double _max = scrollController.position.maxScrollExtent;
    double _cur = scrollController.position.pixels;

    if (_cur == _max) getData();
  }

  reset() {
    max.value = false;
    data.clear();
    getData();
  }

  getData() async {
    if (!max.value) {
      loadMore.value = true;
    }

    if (!max.value) {
      try {
        await ApiService().get(
          url:
              "https://jsonplaceholder.typicode.com/todos?userId=${_curUserId.value}",
          callback: (success, message, response) {
            try {
              if (success) {
                if (_curUserId.value == _lastUserId.value) {
                  max.value = true;
                }
                _curUserId.value++;

                data = data + response;
              } else {
                data = data + [];
              }
            } catch (e) {
              data = data + [];
            }
          },
        );
      } catch (e) {
        data = data + [];
      }
    } else {
      data = data + [];
    }
    loadMore.value = false;
  }
}
