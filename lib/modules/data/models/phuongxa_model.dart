class PhuongXa {
  int? phuongXaId;
  String? maPhuongXa;
  String? tenPhuongXa;
  int? quanHuyenId;
  String? moTa;
  String? maQuanHuyen;

  PhuongXa(
      {this.phuongXaId,
        this.maPhuongXa,
        this.tenPhuongXa,
        this.quanHuyenId,
        this.moTa,
        this.maQuanHuyen});

  PhuongXa.fromJson(Map<String, dynamic> json) {
    phuongXaId = json['phuongXaId'] ?? 0;
    maPhuongXa = json['maPhuongXa'] ?? '';
    tenPhuongXa = json['tenPhuongXa'] ?? '';
    quanHuyenId = json['quanHuyenId'] ?? 0;
    moTa = json['moTa'] ?? '';
    maQuanHuyen = json['maQuanHuyen'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phuongXaId'] = phuongXaId;
    data['maPhuongXa'] = maPhuongXa;
    data['tenPhuongXa'] = tenPhuongXa;
    data['quanHuyenId'] = quanHuyenId;
    data['moTa'] = moTa;
    data['maQuanHuyen'] = maQuanHuyen;
    return data;
  }
}