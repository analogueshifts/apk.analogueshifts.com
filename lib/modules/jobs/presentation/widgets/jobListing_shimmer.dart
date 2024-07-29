import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class JobListingShimmerLoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Shimmer.fromColors(
      baseColor: isLight ? Colors.grey[300]! : Colors.grey[700]!,
      highlightColor:isLight ? Colors.grey[100]! : Colors.grey[300]!,
      child: Column(
        children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 18,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 100,
                          height: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.white,
              ),
              SizedBox(height: 4),
              Container(
                width: 200,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),

          Gap(20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 18,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 100,
                              height: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 200,
                    height: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}