import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/res/app_colors.dart';

class ShimmerListLoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: ListView.builder(
            itemCount: 20,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52.0,
                    height: 52.0,
                    decoration: const BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(26))),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        Container(
                          width: 60.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerGridProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 15, right: 15),
      itemBuilder: (context, position) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.white,
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(
                height: 120,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: AppColors.white,
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(
                width: double.infinity,
                height: 10,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                color: AppColors.white,
              ),
            ),
            Shimmer.fromColors(
              baseColor: AppColors.white,
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(
                width: double.infinity,
                height: 10,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                color: AppColors.white,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
              ),
            ),
          ],
        );
      },
      itemCount: 30,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1),
    );
  }
}
