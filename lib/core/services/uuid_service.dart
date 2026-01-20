import 'package:uuid/uuid.dart';

class UuidService {
  var uuid = Uuid();
  
  static String generateUuid() {
    return Uuid().v4();
  }
}
