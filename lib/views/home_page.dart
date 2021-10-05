import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.1),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 262.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Hi, Alok Mishra',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            'You have 5 targets',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: AppColors.whiteColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.bell_fill,
                          color: AppColors.whiteColor,
                        ),
                        iconSize: 28.0,
                      ),
                    ),
                    CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/flutter_logo.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      backgroundColor: AppColors.whiteColor,
                      radius: 24.0,
                    ),
                    const SizedBox(width: 16.0),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Your Targets',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 172.0,
                    enableInfiniteScroll: true,
                    disableCenter: true,
                  ),
                  items: [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.whiteColor.withOpacity(0.96),
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Learn Flutter',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          Text(
                                            '3 Months Left',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: AppColors.blackColor
                                                  .withOpacity(
                                                0.6,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Expanded(child: SizedBox()),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          CupertinoIcons.ellipsis,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.calendar,
                                        color: AppColors.greyColor,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        '01 November 2021',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color:
                                              AppColors.blackColor.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const SizedBox(width: 8.0),
                                      const CircleAvatar(
                                        backgroundColor: AppColors.greenColor,
                                        radius: 8.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Progress',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color:
                                              AppColors.blackColor.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '80%',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: LinearProgressIndicator(
                                      value: 0.8,
                                      color: AppColors.greenColor,
                                      backgroundColor:
                                          AppColors.greenColor.withOpacity(
                                        0.4,
                                      ),
                                      minHeight: 12.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color: AppColors.whiteColor.withOpacity(0.96),
                      elevation: 4.0,
                      child: Column(
                        children: [
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Learn Flutter',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      '4 out of 8 task left',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: AppColors.blackColor.withOpacity(
                                          0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                const CircleAvatar(
                                  backgroundColor: AppColors.greenColor,
                                  radius: 8.0,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                bottom: 24.0,
                              ),
                              itemCount: 7,
                              itemBuilder: (cxt, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: CheckboxListTile(
                                    value: true,
                                    onChanged: (value) {},
                                    title: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        'UI Design',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: AppColors.blackColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        '09:00 AM 01 Nov - 17:00 AM 02 Nov',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color:
                                              AppColors.blackColor.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    checkColor: AppColors.whiteColor,
                                    activeColor: AppColors.greenColor,
                                  ),
                                );
                              },
                              separatorBuilder: (cxt, index) {
                                return const Divider();
                              },
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(16.0),
                              ),
                            ),
                            color: AppColors.blueColor,
                            child: const SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: Center(
                                child: Text(
                                  'Add Task',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
