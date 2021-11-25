import '../dao/profile_dao.dart';
import '../model/profile_model.dart';

class ProfileRepository {
  final profileDao = ProfileDao();

  Future getProfile() => profileDao.getProfile();

  Future insertProfile(ProfileModel p) => profileDao.createProfile(p);

  Future updateProfile(ProfileModel p) => profileDao.updateProfile(p);

  Future deleteProfileById(int id) => profileDao.deleteProfile(id);
}
