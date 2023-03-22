import '../../modules.dart';

class PhanAnh {
  int? phanAnhId;
  String? ngayPhanAnh;
  String? hanXuLy;
  int? donViXuLyId;
  String? diaChi;
  String? noiDung;
  String? thongTinLienHe;
  LoaiPhanAnh? loaiPhanAnh;
  LoaiViPham? loaiViPham;
  TinhTrangPhanAnh? tinhTrangPhanAnh;
  int? nguoiGuiId;
  double? gpsLat;
  double? gpsLng;
  String? tenDonViXuLy;
  List<TepDinhKems>? tepDinhKems;
  ThongTinXuLy? thongTinXuLy;

  PhanAnh(
      {this.phanAnhId,
      this.ngayPhanAnh,
      this.hanXuLy,
      this.donViXuLyId,
      this.diaChi,
      this.noiDung,
      this.thongTinLienHe,
      this.loaiPhanAnh,
      this.loaiViPham,
      this.tinhTrangPhanAnh,
      this.nguoiGuiId,
      this.gpsLat,
      this.gpsLng,
      this.tenDonViXuLy,
      this.tepDinhKems,
      this.thongTinXuLy});

  PhanAnh.fromJson(Map<String, dynamic> json) {
    phanAnhId = json['phanAnhId'];
    ngayPhanAnh = json['ngayPhanAnh'];
    hanXuLy = json['hanXuLy'];
    donViXuLyId = json['donViXuLyId'];
    diaChi = json['diaChi'];
    noiDung = json['noiDung'];
    thongTinLienHe = json['thongTinLienHe'];
    loaiPhanAnh = json['loaiPhanAnh'] != null
        ? LoaiPhanAnh.fromJson(json['loaiPhanAnh'])
        : null;
    loaiViPham = json['loaiViPham'] != null
        ? LoaiViPham.fromJson(json['loaiViPham'])
        : null;
    tinhTrangPhanAnh = json['tinhTrangPhanAnh'] != null
        ? TinhTrangPhanAnh.fromJson(json['tinhTrangPhanAnh'])
        : null;
    nguoiGuiId = json['nguoiGuiId'];
    gpsLat = json['gpsLat'];
    gpsLng = json['gpsLng'];
    tenDonViXuLy = json['tenDonViXuLy'];
    if (json['tepDinhKems'] != null) {
      tepDinhKems = <TepDinhKems>[];
      json['tepDinhKems'].forEach((v) {
        tepDinhKems!.add(TepDinhKems.fromJson(v));
      });
    }
    thongTinXuLy = json['thongTinXuLy'] != null
        ? ThongTinXuLy.fromJson(json['thongTinXuLy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phanAnhId'] = phanAnhId;
    data['ngayPhanAnh'] = ngayPhanAnh;
    data['hanXuLy'] = hanXuLy;
    data['donViXuLyId'] = donViXuLyId;
    data['diaChi'] = diaChi;
    data['noiDung'] = noiDung;
    data['thongTinLienHe'] = thongTinLienHe;
    if (loaiPhanAnh != null) {
      data['loaiPhanAnh'] = loaiPhanAnh!.toJson();
    }
    if (loaiViPham != null) {
      data['loaiViPham'] = loaiViPham!.toJson();
    }
    if (tinhTrangPhanAnh != null) {
      data['tinhTrangPhanAnh'] = tinhTrangPhanAnh!.toJson();
    }
    data['nguoiGuiId'] = nguoiGuiId;
    data['gpsLat'] = gpsLat;
    data['gpsLng'] = gpsLng;
    data['tenDonViXuLy'] = tenDonViXuLy;
    if (tepDinhKems != null) {
      data['tepDinhKems'] = tepDinhKems!.map((v) => v.toJson()).toList();
    }
    if (thongTinXuLy != null) {
      data['thongTinXuLy'] = thongTinXuLy!.toJson();
    }
    return data;
  }
}

class TinhTrangPhanAnh {
  int? tinhTrangId;
  String? maTinhTrang;
  String? tenTinhTrangCongChuc;
  String? tenTinhTrangDan;
  int? soNgayXuLy;

  TinhTrangPhanAnh(
      {this.tinhTrangId,
      this.maTinhTrang,
      this.tenTinhTrangCongChuc,
      this.tenTinhTrangDan,
      this.soNgayXuLy});

  TinhTrangPhanAnh.fromJson(Map<String, dynamic> json) {
    tinhTrangId = json['tinhTrangId'];
    maTinhTrang = json['maTinhTrang'];
    tenTinhTrangCongChuc = json['tenTinhTrangCongChuc'];
    tenTinhTrangDan = json['tenTinhTrangDan'];
    soNgayXuLy = json['soNgayXuLy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tinhTrangId'] = tinhTrangId;
    data['maTinhTrang'] = maTinhTrang;
    data['tenTinhTrangCongChuc'] = tenTinhTrangCongChuc;
    data['tenTinhTrangDan'] = tenTinhTrangDan;
    data['soNgayXuLy'] = soNgayXuLy;
    return data;
  }
}

class TepDinhKems {
  int? tepDinhKemId;
  int? soHuuId;
  String? duongDan;
  String? ngayDang;
  String? tenTepDinhKem;
  LoaiTepDinhKem? loaiTepDinhKem;

  TepDinhKems(
      {this.tepDinhKemId,
      this.soHuuId,
      this.duongDan,
      this.ngayDang,
      this.tenTepDinhKem,
      this.loaiTepDinhKem});

  TepDinhKems.fromJson(Map<String, dynamic> json) {
    tepDinhKemId = json['tepDinhKemId'];
    soHuuId = json['soHuuId'];
    duongDan = json['duongDan'];
    ngayDang = json['ngayDang'];
    tenTepDinhKem = json['tenTepDinhKem'];
    loaiTepDinhKem = json['loaiTepDinhKem'] != null
        ? LoaiTepDinhKem.fromJson(json['loaiTepDinhKem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tepDinhKemId'] = tepDinhKemId;
    data['soHuuId'] = soHuuId;
    data['duongDan'] = duongDan;
    data['ngayDang'] = ngayDang;
    data['tenTepDinhKem'] = tenTepDinhKem;
    if (loaiTepDinhKem != null) {
      data['loaiTepDinhKem'] = loaiTepDinhKem!.toJson();
    }
    return data;
  }
}

class LoaiTepDinhKem {
  int? loaiTepDinhKemId;
  String? maLoaiTepDinhKem;
  String? tenLoaiTepDinhKem;

  LoaiTepDinhKem(
      {this.loaiTepDinhKemId, this.maLoaiTepDinhKem, this.tenLoaiTepDinhKem});

  LoaiTepDinhKem.fromJson(Map<String, dynamic> json) {
    loaiTepDinhKemId = json['loaiTepDinhKemId'];
    maLoaiTepDinhKem = json['maLoaiTepDinhKem'];
    tenLoaiTepDinhKem = json['tenLoaiTepDinhKem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiTepDinhKemId'] = loaiTepDinhKemId;
    data['maLoaiTepDinhKem'] = maLoaiTepDinhKem;
    data['tenLoaiTepDinhKem'] = tenLoaiTepDinhKem;
    return data;
  }
}

class ThongTinXuLy {
  XuLy? xuLy;
  QuyetDinh? quyetDinh;
  KiemTraKhacPhuc? kiemTraKhacPhuc;
  PhanHoi? phanHoi;
  ThongTinChuyenPhanAnh? thongTinChuyenPhanAnh;
  String? thongTinChuyenBienBan;

  ThongTinXuLy(
      {this.xuLy,
      this.quyetDinh,
      this.kiemTraKhacPhuc,
      this.phanHoi,
      this.thongTinChuyenPhanAnh,
      this.thongTinChuyenBienBan});

  ThongTinXuLy.fromJson(Map<String, dynamic> json) {
    xuLy = json['xuLy'] != null ? XuLy.fromJson(json['xuLy']) : null;
    quyetDinh = json['quyetDinh'] != null
        ? QuyetDinh.fromJson(json['quyetDinh'])
        : null;
    kiemTraKhacPhuc = json['kiemTraKhacPhuc'] != null
        ? KiemTraKhacPhuc.fromJson(json['kiemTraKhacPhuc'])
        : null;
    phanHoi =
        json['phanHoi'] != null ? PhanHoi.fromJson(json['phanHoi']) : null;
    thongTinChuyenPhanAnh = json['thongTinChuyenPhanAnh'];
    thongTinChuyenBienBan = json['thongTinChuyenBienBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (xuLy != null) {
      data['xuLy'] = xuLy!.toJson();
    }
    if (quyetDinh != null) {
      data['quyetDinh'] = quyetDinh!.toJson();
    }
    if (kiemTraKhacPhuc != null) {
      data['kiemTraKhacPhuc'] = kiemTraKhacPhuc!.toJson();
    }
    if (phanHoi != null) {
      data['phanHoi'] = phanHoi!.toJson();
    }
    data['thongTinChuyenPhanAnh'] = thongTinChuyenPhanAnh;
    data['thongTinChuyenBienBan'] = thongTinChuyenBienBan;
    return data;
  }
}

class XuLy {
  int? taiLieuXuLyId;
  String? ngayTao;
  String? noiDung;
  String? hanRaQuyetDinh;
  String? tenChuViPham;
  String? soBienBan;
  LoaiXuLy? loaiXuLy;
  String? tenNguoiXuLy;
  String? tenDonViXuLy;
  String? tenDonViRaQuyetDinh;

  XuLy(
      {this.taiLieuXuLyId,
      this.ngayTao,
      this.noiDung,
      this.hanRaQuyetDinh,
      this.tenChuViPham,
      this.soBienBan,
      this.loaiXuLy,
      this.tenNguoiXuLy,
      this.tenDonViXuLy,
      this.tenDonViRaQuyetDinh});

  XuLy.fromJson(Map<String, dynamic> json) {
    taiLieuXuLyId = json['taiLieuXuLyId'];
    ngayTao = json['ngayTao'];
    noiDung = json['noiDung'];
    hanRaQuyetDinh = json['hanRaQuyetDinh'];
    tenChuViPham = json['tenChuViPham'];
    soBienBan = json['soBienBan'];
    loaiXuLy =
        json['loaiXuLy'] != null ? LoaiXuLy.fromJson(json['loaiXuLy']) : null;
    tenNguoiXuLy = json['tenNguoiXuLy'];
    tenDonViXuLy = json['tenDonViXuLy'];
    tenDonViRaQuyetDinh = json['tenDonViRaQuyetDinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taiLieuXuLyId'] = taiLieuXuLyId;
    data['ngayTao'] = ngayTao;
    data['noiDung'] = noiDung;
    data['hanRaQuyetDinh'] = hanRaQuyetDinh;
    data['tenChuViPham'] = tenChuViPham;
    data['soBienBan'] = soBienBan;
    if (loaiXuLy != null) {
      data['loaiXuLy'] = loaiXuLy!.toJson();
    }
    data['tenNguoiXuLy'] = tenNguoiXuLy;
    data['tenDonViXuLy'] = tenDonViXuLy;
    data['tenDonViRaQuyetDinh'] = tenDonViRaQuyetDinh;
    return data;
  }
}

class LoaiXuLy {
  int? loaiXuLyId;
  String? maLoaiXuLy;
  String? tenLoaiXuLy;

  LoaiXuLy({this.loaiXuLyId, this.maLoaiXuLy, this.tenLoaiXuLy});

  LoaiXuLy.fromJson(Map<String, dynamic> json) {
    loaiXuLyId = json['loaiXuLyId'];
    maLoaiXuLy = json['maLoaiXuLy'];
    tenLoaiXuLy = json['tenLoaiXuLy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiXuLyId'] = loaiXuLyId;
    data['maLoaiXuLy'] = maLoaiXuLy;
    data['tenLoaiXuLy'] = tenLoaiXuLy;
    return data;
  }
}

class QuyetDinh {
  int? quyetDinhId;
  String? soQuyetDinh;
  String? kiHieu;
  String? ngayLap;
  String? noiDung;
  String? tenNguoiLapQuyetDinh;
  LoaiQuyetDinh? loaiQuyetDinh;
  List<TepDinhKems>? tepDinhKems;

  QuyetDinh(
      {this.quyetDinhId,
      this.soQuyetDinh,
      this.kiHieu,
      this.ngayLap,
      this.noiDung,
      this.tenNguoiLapQuyetDinh,
      this.loaiQuyetDinh,
      this.tepDinhKems});

  QuyetDinh.fromJson(Map<String, dynamic> json) {
    quyetDinhId = json['quyetDinhId'];
    soQuyetDinh = json['soQuyetDinh'];
    kiHieu = json['kiHieu'];
    ngayLap = json['ngayLap'];
    noiDung = json['noiDung'];
    tenNguoiLapQuyetDinh = json['tenNguoiLapQuyetDinh'];
    loaiQuyetDinh = json['loaiQuyetDinh'] != null
        ? LoaiQuyetDinh.fromJson(json['loaiQuyetDinh'])
        : null;
    if (json['tepDinhKems'] != null) {
      tepDinhKems = <TepDinhKems>[];
      json['tepDinhKems'].forEach((v) {
        tepDinhKems!.add(TepDinhKems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quyetDinhId'] = quyetDinhId;
    data['soQuyetDinh'] = soQuyetDinh;
    data['kiHieu'] = kiHieu;
    data['ngayLap'] = ngayLap;
    data['noiDung'] = noiDung;
    data['tenNguoiLapQuyetDinh'] = tenNguoiLapQuyetDinh;
    if (loaiQuyetDinh != null) {
      data['loaiQuyetDinh'] = loaiQuyetDinh!.toJson();
    }
    if (tepDinhKems != null) {
      data['tepDinhKems'] = tepDinhKems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoaiQuyetDinh {
  int? loaiQuyetDinhId;
  String? maLoaiQuyetDinh;
  String? tenLoaiQuyetDinh;

  LoaiQuyetDinh(
      {this.loaiQuyetDinhId, this.maLoaiQuyetDinh, this.tenLoaiQuyetDinh});

  LoaiQuyetDinh.fromJson(Map<String, dynamic> json) {
    loaiQuyetDinhId = json['loaiQuyetDinhId'];
    maLoaiQuyetDinh = json['maLoaiQuyetDinh'];
    tenLoaiQuyetDinh = json['tenLoaiQuyetDinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loaiQuyetDinhId'] = loaiQuyetDinhId;
    data['maLoaiQuyetDinh'] = maLoaiQuyetDinh;
    data['tenLoaiQuyetDinh'] = tenLoaiQuyetDinh;
    return data;
  }
}

class KiemTraKhacPhuc {
  int? kiemTraKhacPhucId;
  String? ngayTao;
  int? nguoiKiemTraId;
  int? donViKiemTraId;
  String? noiDung;
  int? quyetDinhId;
  String? tenNguoiKiemTra;
  String? tenDonViKiemTra;
  List<TepDinhKems>? tepDinhKems;

  KiemTraKhacPhuc(
      {this.kiemTraKhacPhucId,
      this.ngayTao,
      this.nguoiKiemTraId,
      this.donViKiemTraId,
      this.noiDung,
      this.quyetDinhId,
      this.tenNguoiKiemTra,
      this.tenDonViKiemTra,
      this.tepDinhKems});

  KiemTraKhacPhuc.fromJson(Map<String, dynamic> json) {
    kiemTraKhacPhucId = json['kiemTraKhacPhucId'];
    ngayTao = json['ngayTao'];
    nguoiKiemTraId = json['nguoiKiemTraId'];
    donViKiemTraId = json['donViKiemTraId'];
    noiDung = json['noiDung'];
    quyetDinhId = json['quyetDinhId'];
    tenNguoiKiemTra = json['tenNguoiKiemTra'];
    tenDonViKiemTra = json['tenDonViKiemTra'];
    if (json['tepDinhKems'] != null) {
      tepDinhKems = <TepDinhKems>[];
      json['tepDinhKems'].forEach((v) {
        tepDinhKems!.add(TepDinhKems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kiemTraKhacPhucId'] = kiemTraKhacPhucId;
    data['ngayTao'] = ngayTao;
    data['nguoiKiemTraId'] = nguoiKiemTraId;
    data['donViKiemTraId'] = donViKiemTraId;
    data['noiDung'] = noiDung;
    data['quyetDinhId'] = quyetDinhId;
    data['tenNguoiKiemTra'] = tenNguoiKiemTra;
    data['tenDonViKiemTra'] = tenDonViKiemTra;
    if (tepDinhKems != null) {
      data['tepDinhKems'] = tepDinhKems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhanHoi {
  int? phanHoiId;
  int? nguoiPhanHoiId;
  String? ngayPhanHoi;
  String? noiDung;
  String? tenNguoiPhanHoi;

  PhanHoi(
      {this.phanHoiId,
      this.nguoiPhanHoiId,
      this.ngayPhanHoi,
      this.noiDung,
      this.tenNguoiPhanHoi});

  PhanHoi.fromJson(Map<String, dynamic> json) {
    phanHoiId = json['phanHoiId'];
    nguoiPhanHoiId = json['nguoiPhanHoiId'];
    ngayPhanHoi = json['ngayPhanHoi'];
    noiDung = json['noiDung'];
    tenNguoiPhanHoi = json['tenNguoiPhanHoi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phanHoiId'] = phanHoiId;
    data['nguoiPhanHoiId'] = nguoiPhanHoiId;
    data['ngayPhanHoi'] = ngayPhanHoi;
    data['noiDung'] = noiDung;
    data['tenNguoiPhanHoi'] = tenNguoiPhanHoi;
    return data;
  }
}

class ThongTinChuyenPhanAnh {
  int? thongTinChuyenId;
  int? nguoiChuyenId;
  String? ngayChuyen;
  String? lyDo;
  String? tenNguoiChuyen;

  ThongTinChuyenPhanAnh(
      {this.thongTinChuyenId,
      this.nguoiChuyenId,
      this.ngayChuyen,
      this.lyDo,
      this.tenNguoiChuyen});

  ThongTinChuyenPhanAnh.fromJson(Map<String, dynamic> json) {
    thongTinChuyenId = json['thongTinChuyenId'];
    nguoiChuyenId = json['nguoiChuyenId'];
    ngayChuyen = json['ngayChuyen'];
    lyDo = json['lyDo'];
    tenNguoiChuyen = json['tenNguoiChuyen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thongTinChuyenId'] = thongTinChuyenId;
    data['nguoiChuyenId'] = nguoiChuyenId;
    data['ngayChuyen'] = ngayChuyen;
    data['lyDo'] = lyDo;
    data['tenNguoiChuyen'] = tenNguoiChuyen;
    return data;
  }
}
