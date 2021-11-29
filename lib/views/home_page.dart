import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/target_bloc.dart';
import 'package:flutter_todo_app/bloc/task_bloc.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/model/target_models.dart';
import 'package:flutter_todo_app/model/task_model.dart';
import 'package:jiffy/jiffy.dart';

import 'target_form.dart';
import 'task_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TargetBloc _targetBloc = TargetBloc();
  final TaskBloc _taskBloc = TaskBloc();
  TargetModel? _selectedTarget;
  File? _image;

  @override
  void dispose() {
    _targetBloc.dispose();
    // _taskBloc.dispose();
    super.dispose();
  }

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
                          StreamBuilder<List<TargetModel>>(
                            stream: _targetBloc.targets,
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final targets = snapshot.data;
                                return Text(
                                  'You have ${targets!.length} targets',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color:
                                        AppColors.whiteColor.withOpacity(0.6),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          CupertinoIcons.bell_fill,
                          color: Colors.transparent,
                        ),
                        iconSize: 28.0,
                      ),
                    ),
                    InkWell(
                      child: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            child: _image != null
                                ? Image.file(
                                    _image ?? File(''),
                                    height: 40.0,
                                    width: 40.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
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
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg'],
                        );

                        if (result != null) {
                          /// Save result.files.single.path to profile database
                          _image = File(result.files.single.path ?? '');
                          setState(() {});
                        }
                      },
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
                            onPageChanged: (i, r) {
                              _selectedTarget = targets![i];
                              setState(() {});
                            }),
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
                                                  FutureBuilder<
                                                      List<TaskModel>>(
                                                    future: _taskBloc.getTasks(
                                                      queryKey: 'targetId',
                                                      queryValue:
                                                          i.id.toString(),
                                                    ),
                                                    builder: (cxt, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                          'You have '
                                                          '${snapshot.data!.length} '
                                                          'tasks',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
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
                                            FutureBuilder<List<TaskModel>>(
                                              future: _taskBloc.getTasks(
                                                queryKey: 'targetId',
                                                queryValue: i.id.toString(),
                                              ),
                                              builder: (c, s) {
                                                if (s.hasData) {
                                                  int finishedCount = 0;
                                                  for (var t in s.data!) {
                                                    if (t.isFinished ?? false) {
                                                      finishedCount++;
                                                    }
                                                  }
                                                  return Text(
                                                    s.data!.isEmpty
                                                        ? '100%'
                                                        : '${(100 * finishedCount / s.data!.length)}%',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        FutureBuilder<List<TaskModel>>(
                                          future: _taskBloc.getTasks(
                                            queryKey: 'targetId',
                                            queryValue: i.id.toString(),
                                          ),
                                          builder: (cxt, snapshot) {
                                            if (snapshot.hasData) {
                                              int finishedCount = 0;
                                              for (var t in snapshot.data!) {
                                                if (t.isFinished ?? false) {
                                                  finishedCount++;
                                                }
                                              }
                                              // finishedTask / total
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: LinearProgressIndicator(
                                                  value: snapshot.data!.isEmpty
                                                      ? 1.0
                                                      : (finishedCount /
                                                          snapshot
                                                              .data!.length),
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
                                                          .withOpacity(0.2)
                                                      : AppColors.greenColor
                                                          .withOpacity(0.2),
                                                  minHeight: 12.0,
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
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
                if (_selectedTarget != null)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_selectedTarget!.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      FutureBuilder<List<TaskModel>>(
                                        future: _taskBloc.getTasks(
                                          queryKey: 'targetId',
                                          queryValue:
                                              _selectedTarget!.id.toString(),
                                        ),
                                        builder: (cxt, snapshot) {
                                          int finished = 0;
                                          for (var t in snapshot.data!) {
                                            if (t.isFinished ?? false) {
                                              finished++;
                                            }
                                          }
                                          if (snapshot.hasData) {
                                            return Text(
                                              '$finished '
                                              'out of '
                                              '${snapshot.data!.length} '
                                              'task left',
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
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  CircleAvatar(
                                    backgroundColor: Jiffy(
                                      _selectedTarget!.deadline ?? '',
                                      "E, MMM d, yyyy",
                                    ).isBefore(DateTime.now())
                                        ? AppColors.redColor
                                        : AppColors.greenColor,
                                    radius: 8.0,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: FutureBuilder<List<TaskModel>>(
                                future: _taskBloc.getTasks(
                                  queryKey: 'targetId',
                                  queryValue: _selectedTarget!.id.toString(),
                                ),
                                builder: (c, s) {
                                  if (s.hasData) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.only(
                                        bottom: 24.0,
                                      ),
                                      itemCount: s.data!.length,
                                      itemBuilder: (cxt, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CheckboxListTile(
                                                  value:
                                                      s.data![index].isFinished,
                                                  onChanged: (value) async {
                                                    await _taskBloc.updateTask(
                                                      TaskModel(
                                                        id: s.data![index].id,
                                                        title: s
                                                            .data![index].title,
                                                        finish: s.data![index]
                                                            .finish,
                                                        start: s
                                                            .data![index].start,
                                                        targetId: s.data![index]
                                                            .targetId,
                                                        isFinished: value,
                                                      ),
                                                    );
                                                    setState(() {});
                                                  },
                                                  title: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Text(
                                                      s.data![index].title ??
                                                          '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0,
                                                        color: AppColors
                                                            .blackColor,
                                                        decoration: s
                                                                    .data![
                                                                        index]
                                                                    .isFinished ??
                                                                false
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : TextDecoration
                                                                .none,
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Text(
                                                      '${s.data![index].start} '
                                                      '- '
                                                      '${s.data![index].finish}',
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
                                                  ),
                                                  dense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  checkColor:
                                                      AppColors.whiteColor,
                                                  activeColor:
                                                      AppColors.greenColor,
                                                ),
                                              ),
                                              PopupMenuButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12.0,
                                                  ),
                                                ),
                                                itemBuilder: (_) => [
                                                  const PopupMenuItem(
                                                    child: Text("Update"),
                                                    value: 1,
                                                  ),
                                                  const PopupMenuItem(
                                                    child: Text("Delete"),
                                                    value: 2,
                                                  ),
                                                ],
                                                onSelected: (value) async {
                                                  switch (value) {
                                                    case 1:
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (cxt) {
                                                          return TaskForm(
                                                            onSave: () {
                                                              setState(() {});
                                                            },
                                                            targetId: s
                                                                    .data![
                                                                        index]
                                                                    .targetId ??
                                                                0,
                                                            task:
                                                                s.data![index],
                                                          );
                                                        },
                                                      );
                                                      break;
                                                    case 2:
                                                      await _taskBloc
                                                          .deleteTaskById(
                                                        s.data![index].id ?? 0,
                                                      );
                                                      setState(() {});
                                                      break;
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (cxt, index) {
                                        return const Divider();
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (_selectedTarget != null) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (cxt) {
                                      return TaskForm(
                                        targetId: _selectedTarget!.id ?? 0,
                                        onSave: () {
                                          setState(() {});
                                        },
                                      );
                                    },
                                  );
                                }
                              },
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
