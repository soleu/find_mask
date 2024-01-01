class Store { // 클래스 이름은 대문자, 다트파일은 소문자
  String? addr;
  String? code;
  String? createdAt;
  num? lat;  // num == int, double 을 모두 포함
  num? lng;
  double? km;
  String? name;
  String? remainStat;
  String? stockAt;
  String? type;

  Store(
      {this.addr,
        this.code,
        this.createdAt,
        this.lat,
        this.lng,
        this.name,
        this.remainStat,
        this.stockAt,
        this.type});

  Store.fromJson(Map<String, dynamic> json) {
    addr = json['addr'];
    code = json['code'];
    createdAt = json['created_at'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    remainStat = json['remain_stat'];
    stockAt = json['stock_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr'] = this.addr;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['remain_stat'] = this.remainStat;
    data['stock_at'] = this.stockAt;
    data['type'] = this.type;
    return data;
  }
}
