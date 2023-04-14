import 'package:phan_anh/modules/data/data.dart';

class Filter{
  LoaiPhanAnh? phananh;
  Duong? duong;
  PhuongXa? phuongXa;
  String? tuNgay;
  String? denNgay;
  List<LoaiViPham>? loaiViPhamIds;

  Filter({this.phananh,this.duong,this.phuongXa,this.tuNgay,this.denNgay,this.loaiViPhamIds});
}