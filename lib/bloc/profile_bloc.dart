import 'dart:async';

import 'package:flutter_todo_app/model/profile_model.dart';
import 'package:flutter_todo_app/repository/profile_repository.dart';

class ProfileBloc {
  final _profileRepository = ProfileRepository();

  final _profileController = StreamController<ProfileModel>.broadcast();

  get profile => _profileController.stream;

  ProfileBloc() {
    getProfile();
  }

  getProfile() async {
    _profileController.sink.add(
      await _profileRepository.getProfile(),
    );
  }

  createProfile(ProfileModel p) async {
    await _profileRepository.insertProfile(p);
    getProfile();
  }

  updateProfile(ProfileModel p) async {
    await _profileRepository.updateProfile(p);
    getProfile();
  }

  deleteProfileById(int id) async {
    _profileRepository.deleteProfileById(id);
    getProfile();
  }

  dispose() {
    _profileController.close();
  }
}
