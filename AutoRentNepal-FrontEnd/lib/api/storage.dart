import 'package:auto_rent_nepal_fyp/main.dart';

// checkLogin() async {
//   String? tokenNo = await secureStorage?.read(key: 'key');
//   if (tokenNo != null)
//     return true;
//   else
//     return false;
// }
Future checkToken() async {
  var tokens = await secureStorage?.read(key: 'key');

  return tokens;
}

//store token
saveLogin(key) async {
  await secureStorage?.write(key: 'key', value: '$key');
}

//this function deletes all the token that is stored.
deleteLogin() async {
  await secureStorage?.deleteAll();
}

savePrice(int) async {
  await secureStorage?.write(key: int, value: int);
}
