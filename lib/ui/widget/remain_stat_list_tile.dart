import 'package:flutter/material.dart';

import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return _buildRemainStatWidget(store);
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매 중지';
    var desc = '없음';
    var color = Colors.black;
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        desc = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        desc = '30개 이상';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        desc = '2개 이상';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '';
        desc = '1개 이하';
        color = Colors.grey;
        break;
    }

    return Column(
      children: [
        Text(remainStat,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(
          desc,
          style: TextStyle(color: color),
        )
      ],
    );
  }

}
