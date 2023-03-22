class Duong {
  int? duongId;
  String? tenVietTat;
  String? tenDuong;
  String? moTa;
  bool? used;
  int? phuongXaId;

  Duong(
      {this.duongId,
        this.tenVietTat,
        this.tenDuong,
        this.moTa,
        this.used,
        this.phuongXaId});

  Duong.fromJson(Map<String, dynamic> json) {
    duongId = json['duongId'] ?? 0;
    tenVietTat = json['tenVietTat'] ?? '';
    tenDuong = json['tenDuong'] ?? '';
    moTa = json['moTa'] ?? '';
    used = json['used'] ?? false;
    phuongXaId = json['phuongXaId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duongId'] = duongId;
    data['tenVietTat'] = tenVietTat;
    data['tenDuong'] = tenDuong;
    data['moTa'] = moTa;
    data['used'] = used;
    data['phuongXaId'] = phuongXaId;
    return data;
  }
}
