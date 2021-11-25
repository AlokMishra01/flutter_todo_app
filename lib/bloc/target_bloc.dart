import 'dart:async';

import '../model/target_models.dart';
import '../repository/target_repository.dart';

class TargetBloc {
  //Get instance of the Repository
  final _targetRepository = TargetRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _targetController = StreamController<List<TargetModel>>.broadcast();

  get targets => _targetController.stream;

  TargetBloc() {
    getTargets();
  }

  getTargets({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _targetController.sink.add(
      await _targetRepository.getAllTargets(query: query),
    );
  }

  addTarget(TargetModel target) async {
    await _targetRepository.insertTargets(target);
    getTargets();
  }

  updateTarget(TargetModel target) async {
    await _targetRepository.updateTargets(target);
    getTargets();
  }

  deleteTargetById(int id) async {
    _targetRepository.deleteTargetsById(id);
    getTargets();
  }

  dispose() {
    _targetController.close();
  }
}
