import '../models/user.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider {
  final User _currentUser = User.empty();
  User get user => _currentUser;

  setUserName(String value) {
    _currentUser.name = value;
    notifyListeners();
  }
}
