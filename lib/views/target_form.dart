import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/target_bloc.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/model/target_models.dart';
import 'package:jiffy/jiffy.dart';

class TargetForm extends StatefulWidget {
  final VoidCallback onSave;
  final TargetModel? target;

  const TargetForm({
    Key? key,
    required this.onSave,
    this.target,
  }) : super(key: key);

  @override
  State<TargetForm> createState() => _TargetFormState();
}

class _TargetFormState extends State<TargetForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  late DateTime _selectedDate;

  final TargetBloc _targetBloc = TargetBloc();

  @override
  void initState() {
    super.initState();
    if (widget.target != null) {
      _titleController.text = widget.target!.title ?? '';
      _deadlineController.text = widget.target!.deadline ?? '';
      _selectedDate = Jiffy(
        widget.target!.deadline ?? '',
        "E, MMM d, yyyy",
      ).dateTime;
    } else {
      _deadlineController.text = Jiffy().yMMMEd;
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _deadlineController.dispose();
    _targetBloc.dispose();
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
                '${widget.target == null ? 'Add' : 'Update'} Target',
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
                'Target Title',
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
                return 'Target Title Should Have At Least 4 Characters';
              }
            },
          ),
          const SizedBox(height: 16.0),
          InkWell(
            child: TextFormField(
              controller: _deadlineController,
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
                  'Target Deadline',
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
                  return 'Please Select Target Deadline';
                }
              },
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
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
                _deadlineController.text = Jiffy(date).yMMMEd;
                _selectedDate = date;
              }
            },
          ),
          const SizedBox(height: 16.0),
          MaterialButton(
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) return;
              if (widget.target == null) {
                await _targetBloc.addTarget(
                  TargetModel(
                    title: _titleController.text.trim(),
                    deadline: _deadlineController.text.trim(),
                  ),
                );
              } else {
                await _targetBloc.updateTarget(
                  TargetModel(
                    id: widget.target!.id,
                    title: _titleController.text.trim(),
                    deadline: _deadlineController.text.trim(),
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
                  widget.target != null ? 'Update' : 'Save',
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
