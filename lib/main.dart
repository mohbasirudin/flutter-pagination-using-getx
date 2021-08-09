import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pagination/controller_main.dart';
import 'package:getx_pagination/model_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/main",
      getPages: [
        GetPage(
          name: "/main",
          page: () => PageMain(),
          binding: BindingMain(),
        ),
      ],
    );
  }
}

class PageMain extends GetView<ControllerMain> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Pagination Using GetX",
            style: TextStyle(
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: ListView.builder(
          controller: controller.scrollController,
          itemCount: (controller.loadMore.value && !controller.max.value)
              ? (controller.data.length + 1)
              : controller.data.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (index < controller.data.length) {
              ModelTest _data = controller.data[index];
              return Container(
                color: index % 2 == 1 ? Colors.grey.shade100 : Colors.white,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "No. ${_data.id}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      _data.title,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
