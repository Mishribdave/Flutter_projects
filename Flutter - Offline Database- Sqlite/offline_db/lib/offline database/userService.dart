import 'package:sqflite_assignment/offline%20database/repository.dart';
import 'package:sqflite_assignment/offline%20database/usermodel.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  saveuser(UserModel userModel) async {
    return await _repository.insertdata("USER", userModel.UserModelMap());
  }

  readuser() async {
    return await _repository.readalldata("USER");
  }

  updateuser(UserModel userModel) async {
    return await _repository.updatedata("USER", userModel.UserModelMap());
  }

  deleteuser(userid) async {
    return await _repository.deleteData("USER", userid);
  }
}
