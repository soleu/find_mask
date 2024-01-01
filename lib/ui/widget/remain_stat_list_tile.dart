import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(store.addr ?? ''), Text('${store.km} km' ?? '')],
      ),
      trailing: _buildRemainStatWidget(store),
      // 오른쪽 끝 영역. 위젯같은건 그냥 static 으로 넣음
      onTap: () async {
        await _launchUrl(store.lat, store.lng);
      },
    );
  }

  Future<void> _launchUrl(num? lat, num? lng) async {
    print(lat);
    final Uri _url = Uri.parse('https://google.co.kr/maps/place/$lat,$lng');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
