import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/target_bloc.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/model/target_models.dart';
import 'package:jiffy/jiffy.dart';

import 'target_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TargetBloc _targetBloc = TargetBloc();

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
                StreamBuilder<List<TargetModel>>(
                  stream: _targetBloc.targets,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final targets = snapshot.data;
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 172.0,
                          enableInfiniteScroll: true,
                          disableCenter: true,
                        ),
                        items: targets!.map((i) {
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    i.title ?? '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    'You have 0 tasks',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0,
                                                      color: AppColors
                                                          .blackColor
                                                          .withOpacity(
                                                        0.6,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  child: Text("Update"),
                                                  value: 1,
                                                ),
                                                const PopupMenuItem(
                                                  child: Text("Delete"),
                                                  value: 2,
                                                ),
                                              ],
                                              onSelected: (v) async {
                                                switch (v) {
                                                  case 1:
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (cxt) {
                                                        return TargetForm(
                                                          onSave: () {
                                                            setState(() {});
                                                          },
                                                          target: i,
                                                        );
                                                      },
                                                    );
                                                    break;
                                                  case 2:
                                                    await _targetBloc
                                                        .deleteTargetById(
                                                      i.id ?? 0,
                                                    );
                                                    setState(() {});
                                                    break;
                                                }
                                              },
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
                                              i.deadline ?? '',
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
                                            const Expanded(child: SizedBox()),
                                            const SizedBox(width: 8.0),
                                            CircleAvatar(
                                              backgroundColor: Jiffy(
                                                i.deadline ?? '',
                                                "E, MMM d, yyyy",
                                              ).isBefore(DateTime.now())
                                                  ? AppColors.redColor
                                                  : AppColors.greenColor,
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
                                                color: AppColors.blackColor
                                                    .withOpacity(
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
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          child: LinearProgressIndicator(
                                            value: 0.8,
                                            color: Jiffy(
                                              i.deadline ?? '',
                                              "E, MMM d, yyyy",
                                            ).isBefore(DateTime.now())
                                                ? AppColors.redColor
                                                : AppColors.greenColor,
                                            backgroundColor: Jiffy(
                                              i.deadline ?? '',
                                              "E, MMM d, yyyy",
                                            ).isBefore(DateTime.now())
                                                ? AppColors.redColor
                                                    .withOpacity(0.4)
                                                : AppColors.greenColor
                                                    .withOpacity(0.4),
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
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                // StreamBuilder<List<TargetModel>>(
                //   stream: _targetBloc.targets,
                //   builder: (cxt, snapshot) {
                //     final targets = snapshot.data;
                //     if (snapshot.hasData) {
                //       return CarouselSlider(
                //         options: CarouselOptions(
                //           height: 172.0,
                //           enableInfiniteScroll: true,
                //           disableCenter: true,
                //         ),
                //         items: targets!.map((i) {
                //           return Builder(
                //             builder: (BuildContext context) {
                //               return Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Material(
                //                   borderRadius: BorderRadius.circular(16.0),
                //                   color: AppColors.whiteColor.withOpacity(0.96),
                //                   elevation: 4.0,
                //                   child: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                       horizontal: 16.0,
                //                       vertical: 8.0,
                //                     ),
                //                     child: Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Text(
                //                                   i.title ?? '',
                //                                   maxLines: 1,
                //                                   overflow:
                //                                       TextOverflow.ellipsis,
                //                                   style: const TextStyle(
                //                                     fontWeight: FontWeight.bold,
                //                                     fontSize: 16.0,
                //                                     color: AppColors.blackColor,
                //                                   ),
                //                                 ),
                //                                 Text(
                //                                   'You have 0 tasks',
                //                                   maxLines: 1,
                //                                   overflow:
                //                                       TextOverflow.ellipsis,
                //                                   style: TextStyle(
                //                                     fontWeight: FontWeight.bold,
                //                                     fontSize: 12.0,
                //                                     color: AppColors.blackColor
                //                                         .withOpacity(
                //                                       0.6,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                             const Expanded(child: SizedBox()),
                //                             PopupMenuButton(
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(
                //                                   12.0,
                //                                 ),
                //                               ),
                //                               itemBuilder: (context) => [
                //                                 const PopupMenuItem(
                //                                   child: Text("Update"),
                //                                   value: 1,
                //                                 ),
                //                                 const PopupMenuItem(
                //                                   child: Text("Delete"),
                //                                   value: 2,
                //                                 )
                //                               ],
                //                               onSelected: (v) async {
                //                                 switch (v) {
                //                                   case 1:
                //                                     showModalBottomSheet(
                //                                       context: context,
                //                                       builder: (cxt) {
                //                                         return TargetForm(
                //                                           onSave: () {
                //                                             setState(() {});
                //                                           },
                //                                           target: i,
                //                                         );
                //                                       },
                //                                     );
                //                                     break;
                //                                   case 2:
                //                                     await _targetBloc
                //                                         .deleteTargetById(
                //                                       i.id ?? 0,
                //                                     );
                //                                     setState(() {});
                //                                     break;
                //                                 }
                //                               },
                //                             ),
                //                           ],
                //                         ),
                //                         const Divider(),
                //                         Row(
                //                           children: [
                //                             const Icon(
                //                               CupertinoIcons.calendar,
                //                               color: AppColors.greyColor,
                //                             ),
                //                             const SizedBox(width: 8.0),
                //                             Text(
                //                               i.deadline ?? '',
                //                               maxLines: 1,
                //                               overflow: TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 12.0,
                //                                 color: AppColors.blackColor
                //                                     .withOpacity(
                //                                   0.6,
                //                                 ),
                //                               ),
                //                             ),
                //                             const Expanded(child: SizedBox()),
                //                             const SizedBox(width: 8.0),
                //                             CircleAvatar(
                //                               backgroundColor: Jiffy(
                //                                 i.deadline ?? '',
                //                                 "E, MMM d, yyyy",
                //                               ).isBefore(DateTime.now())
                //                                   ? AppColors.redColor
                //                                   : AppColors.greenColor,
                //                               radius: 8.0,
                //                             ),
                //                             const SizedBox(width: 8.0),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 8.0),
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(
                //                               'Progress',
                //                               maxLines: 1,
                //                               overflow: TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 12.0,
                //                                 color: AppColors.blackColor
                //                                     .withOpacity(
                //                                   0.6,
                //                                 ),
                //                               ),
                //                             ),
                //                             const Text(
                //                               '80%',
                //                               maxLines: 1,
                //                               overflow: TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 12.0,
                //                                 color: AppColors.blackColor,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 8.0),
                //                         ClipRRect(
                //                           borderRadius:
                //                               BorderRadius.circular(6.0),
                //                           child: LinearProgressIndicator(
                //                             value: 0.8,
                //                             color: Jiffy(
                //                               i.deadline ?? '',
                //                               "E, MMM d, yyyy",
                //                             ).isBefore(DateTime.now())
                //                                 ? AppColors.redColor
                //                                 : AppColors.greenColor,
                //                             backgroundColor: Jiffy(
                //                               i.deadline ?? '',
                //                               "E, MMM d, yyyy",
                //                             ).isBefore(DateTime.now())
                //                                 ? AppColors.redColor
                //                                     .withOpacity(0.4)
                //                                 : AppColors.greenColor
                //                                     .withOpacity(0.4),
                //                             minHeight: 12.0,
                //                           ),
                //                         ),
                //                         const SizedBox(height: 8.0),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           );
                //         }).toList(),
                //       );
                //     } else {
                //       return const CircularProgressIndicator();
                //     }
                //   },
                // ),
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
