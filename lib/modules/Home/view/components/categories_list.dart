import 'package:cached_network_image/cached_network_image.dart';

import 'package:capotcha/modules/Home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';

class CategoriesList extends StatelessWidget {
  final List<DataCategory>? data;

  const CategoriesList({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Expanded(
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data!.length,
              padding: EdgeInsets.only(bottom: 8.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                crossAxisCount: 1,
              ),
              itemBuilder: (context, int index) {
                return data![index].id == 31
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap: () async {
                            Get.toNamed(Routes.ProductScreen, arguments: index);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.darken),
                                      image: CachedNetworkImageProvider(
                                        Constants.imgUrl + data![index].image!,
                                      ),
                                      fit: BoxFit.cover)),
                              child: Center(
                                  child: Text(data![index].name!,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w500))),
                            ),
                          ),
                        ),
                      );
              }),
        ),
      ],
    );
  }
}
