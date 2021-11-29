import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/task_bloc.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/model/task_model.dart';
import 'package:jiffy/jiffy.dart';

class TaskForm extends StatefulWidget {
  final int targetId;
  final VoidCallback onSave;
  final TaskModel? task;

  const TaskForm({
    Key? key,
    required this.targetId,
    required this.onSave,
    this.task,
  }) : super(key: key);

  @override
  State<TaskForm> createState() => _TargetFormState();
}

class _TargetFormState extends State<TaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;

  final TaskBloc _taskBloc = TaskBloc();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? '';
      _startController.text = widget.task!.start ?? '';
      _endController.text = widget.task!.finish ?? '';
      _startDate = Jiffy(
        widget.task!.start ?? '',
        "E, MMM d, yyyy",
      ).dateTime;
      _endDate = Jiffy(
        widget.task!.finish ?? '',
        "E, MMM d, yyyy",
      ).dateTime;
    } else {
      _startController.text = Jiffy().yMMMEd;
      _startDate = DateTime.now();
      _endController.text = Jiffy().yMMMEd;
      _endDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startController.dispose();
    _endController.dispose();
    // _taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.task == null ? 'Add' : 'Update'} Task',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                color: AppColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: AppColors.blueColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: AppColors.blueColor,
                ),
              ),
              label: const Text(
                'Task Title',
              ),
              labelStyle: const TextStyle(
                color: AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
            style: const TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length < 4) {
                return 'Task Title Should Have At Least 4 Characters';
              }
            },
          ),
          const SizedBox(height: 16.0),
          InkWell(
            child: TextFormField(
              controller: _startController,
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColors.blueColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColors.blueColor,
                  ),
                ),
                label: const Text(
                  'Starting At',
                ),
                labelStyle: const TextStyle(
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              style: const TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Select Task Starting At';
                }
              },
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.blueColor,
                        surface: AppColors.blueColor,
                      ),
                    ),
                    child: child ?? Container(),
                  );
                },
              );
              if (date != null) {
                _startController.text = Jiffy(date).yMMMEd;
                _startDate = date;
              }
            },
          ),
          const SizedBox(height: 16.0),
          InkWell(
            child: TextFormField(
              controller: _endController,
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColors.blueColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColors.blueColor,
                  ),
                ),
                label: const Text(
                  'Ending At',
                ),
                labelStyle: const TextStyle(
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              style: const TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Select Task Ending At';
                }
              },
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.blueColor,
                        surface: AppColors.blueColor,
                      ),
                    ),
                    child: child ?? Container(),
                  );
                },
              );
              if (date != null) {
                _endController.text = Jiffy(date).yMMMEd;
                _endDate = date;
              }
            },
          ),
          const SizedBox(height: 16.0),
          MaterialButton(
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) return;
              if (widget.task == null) {
                await _taskBloc.addTask(
                  TaskModel(
                    targetId: widget.targetId,
                    title: _titleController.text.trim(),
                    start: _startController.text.trim(),
                    finish: _endController.text.trim(),
                    isFinished: false,
                  ),
                );
              } else {
                await _taskBloc.updateTask(
                  TaskModel(
                    id: widget.task!.id,
                    targetId: widget.targetId,
                    title: _titleController.text.trim(),
                    start: _startController.text.trim(),
                    finish: _endController.text.trim(),
                    isFinished: false,
                  ),
                );
              }
              widget.onSave();
              Navigator.maybePop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: AppColors.blueColor,
            child: SizedBox(
              width: double.infinity,
              height: 48.0,
              child: Center(
                child: Text(
                  widget.task != null ? 'Update' : 'Save',
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}
