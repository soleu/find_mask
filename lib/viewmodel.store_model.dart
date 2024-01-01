import 'package:find_mask/repository/store_repository.dart';
import 'package:flutter/cupertino.dart';

class StoreModel with ChangeNotifier{
  final _storeRepository = StoreRepository();

  Future fetch(){
    _storeRepository.fetch();
  }
}