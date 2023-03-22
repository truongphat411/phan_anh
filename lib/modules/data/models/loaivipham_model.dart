class LoaiViPham {
  int? loaiViPhamId;
  String? maLoaiViPham;
  String? tenLoaiViPham;
  int? loaiPhanAnhId;
  String? moTa;
  bool selected = false;

  LoaiViPham(
      {this.loaiViPhamId,
        this.maLoaiViPham,
        this.tenLoaiViPham,
        this.loaiPhanAnhId,
        this.moTa,
        required this.selected});

  LoaiViPham.fromJson(Map<String, dynamic> json) {
    loaiViPhamId = json['loaiViPhamId'];
    maLoaiViPham = json['maLoaiViPham'];
    tenLoaiViPham = json['tenLoaiViPham'];
    loaiPhanAnhId = json['loaiPhanAnhId'];
    moTa = json['moTa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiViPhamId'] = loaiViPhamId;
    data['maLoaiViPham'] = maLoaiViPham;
    data['tenLoaiViPham'] = tenLoaiViPham;
    data['loaiPhanAnhId'] = loaiPhanAnhId;
    data['moTa'] = moTa;
    return data;
  }
}