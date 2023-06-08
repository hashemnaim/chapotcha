import 'package:capotcha/modules/Home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_network_image.dart';
import '../../controller/home_controller.dart';

class CategoriesList extends StatelessWidget {
  final List<DataCategory>? data;
  CategoriesList({Key? key, this.data}) : super(key: key);

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8.h),
      Expanded(
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data!.length,
              padding: EdgeInsets.only(bottom: 8.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2, crossAxisCount: 1),
              itemBuilder: (context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                        onTap: () async {
                          homeController.getCatogry(data![index].id.toString());
                          Get.toNamed(Routes.ProductScreen, arguments: index);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Stack(
                              children: [
                                CustomNetworkImage(
                                  Constants.imgUrl + data![index].image!,
                                  width: 300,
                                  heigth: 300.h,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: 300,
                                  height: 300.h,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                Transform.translate(
                                  offset: Offset(0.0, 35.h),
                                  child: Text(data![index].name!,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 22.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                )
                              ],
                            ))));
              }))
    ]);
  }
}
