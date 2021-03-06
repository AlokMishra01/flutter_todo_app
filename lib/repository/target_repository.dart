import '../dao/target_dao.dart';
import '../model/target_models.dart';

class TargetRepository {
  final targetDao = TargetDao();

  Future getAllTargets({String? query}) => targetDao.getTargets(query: query);

  Future insertTargets(TargetModel target) => targetDao.createTarget(target);

  Future updateTargets(TargetModel target) => targetDao.updateTarget(target);

  Future deleteTargetsById(int id) => targetDao.deleteTarget(id);

  Future deleteAllTargets() => targetDao.deleteAllTargets();
}
