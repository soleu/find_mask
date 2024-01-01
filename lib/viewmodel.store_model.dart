import 'package:find_mask/model/store.dart';
import 'package:find_mask/repository/store_repository.dart';
import 'package:flutter/cupertino.dart';

class StoreModel with ChangeNotifier {
  List<Store> stores = [];
  final _storeRepository = StoreRepository();

  Future fetch() async {
    stores = await _storeRepository.fetch();
    notifyListeners(); // 변경이 다 되었음을 통지
  }
}
