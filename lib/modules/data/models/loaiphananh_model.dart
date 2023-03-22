class LoaiPhanAnh {
  int? loaiPhanAnhId;
  String? maLoaiPhanAnh;
  String? tenLoaiPhanAnh;
  String? maPhanLoai;
  String? moTa;

  LoaiPhanAnh(
      {this.loaiPhanAnhId,
        this.maLoaiPhanAnh,
        this.tenLoaiPhanAnh,
        this.maPhanLoai,
        this.moTa});

  LoaiPhanAnh.fromJson(Map<String, dynamic> json) {
    loaiPhanAnhId = json['loaiPhanAnhId'];
    maLoaiPhanAnh = json['maLoaiPhanAnh'];
    tenLoaiPhanAnh = json['tenLoaiPhanAnh'];
    maPhanLoai = json['maPhanLoai'];
    moTa = json['moTa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiPhanAnhId'] = loaiPhanAnhId;
    data['maLoaiPhanAnh'] = maLoaiPhanAnh;
    data['tenLoaiPhanAnh'] = tenLoaiPhanAnh;
    data['maPhanLoai'] = maPhanLoai;
    data['moTa'] = moTa;
    return data;
  }
}