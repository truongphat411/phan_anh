import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:phan_anh/modules/providers/bottom_sheet_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/utils.dart';
import '../modules.dart';


class BottomSheetPA extends StatefulWidget {
  const BottomSheetPA({Key? key, required this.filter,required this.listLPA})
      : super(key: key);


  final Filter filter;

  final List<LoaiPhanAnh> listLPA;

  @override
  State<BottomSheetPA> createState() => _BottomSheetPAState();
}

class _BottomSheetPAState extends State<BottomSheetPA> {
  final BottomSheetProvider _bottomSheetPAProvider = BottomSheetProvider();
  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Chọn ngày'),
            content: SizedBox(
              height: 300,
              width: 100,
              child: Theme(
                data: ThemeData(
                  primaryColor: ColorSelect.mainColor,
                  // set your desired color
                ),
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  toggleDaySelection: true,
                  onSubmit: (value) {
                    if (value is PickerDateRange) {
                      _bottomSheetPAProvider.setFromDate(value.startDate);
                      _bottomSheetPAProvider.setToDate(value.endDate);
                      Navigator.of(context).pop();
                      print('PhatNMT date range: $value');
                    }
                  },
                  controller: dateRangePickerController,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomSheetProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 600,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 0,
                        bottom: 0,
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Text(
                            'Lọc phản ánh',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        top: 0,
                        child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Center(
                              child: Container(
                                color: ColorSelect.backGroundColor,
                                child: Text(
                                  'Thiết lập lại',
                                  style: TextStyle(
                                      color: ColorSelect.mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _itemFiled(
                    name: widget.filter.phananh?.tenLoaiPhanAnh,
                    hintText: '',
                    provider: provider,
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) => DialogPicker(title: 'Chọn loại phản ánh', list: widget.listLPA,),
                  );
                }),
                Visibility(
                  visible: widget.filter.loaiViPhamIds!.isNotEmpty,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.filter.loaiViPhamIds!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            widget.filter.loaiViPhamIds![index].selected =
                                !widget.filter.loaiViPhamIds![index].selected;
                            provider.updateLoaiVPList(provider.loaiVPList);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: widget.filter.loaiViPhamIds![index]
                                            .selected ==
                                        true
                                    ? ColorSelect.mainColor
                                    : Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: Colors.grey[350]!, width: 2)),
                            child: Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              widget
                                  .filter.loaiViPhamIds![index].tenLoaiViPham!,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: widget.filter.loaiViPhamIds![index]
                                              .selected ==
                                          true
                                      ? ColorSelect.secondaryColor
                                      : Colors.grey),
                              overflow: TextOverflow.clip,
                            )),
                          ),
                        );
                      }),
                ),
                _itemFiled(hintText: 'Chọn Xã/Thị trấn', provider: provider),
                _itemFiled(hintText: 'Chọn đường', provider: provider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                        child: _itemFiled(
                            hintText: 'Từ ngày',
                            isIcon: false,
                            provider: provider)),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                        child: _itemFiled(
                            hintText: 'Đến ngày',
                            isIcon: false,
                            provider: provider)),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () => _showDatePicker(context),
                      child: Icon(
                        Icons.calendar_month,
                        color: ColorSelect.mainColor,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: ColorSelect.mainColor,
                    ),
                    height: 50,
                    child: const Center(
                      child: Text('Lọc'),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _itemFiled(
      {double? width,
      String? name,
      String hintText = '',
      isIcon = true,
      required BottomSheetProvider provider,
      VoidCallback? onTap}) {

    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
        width: width,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey[300]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name ?? hintText,
                style: name == null
                    ? const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
            isIcon
                ? name == null
                    ? const Icon(Icons.arrow_drop_down_outlined)
                    : const Icon(Icons.close)
                : Container()
            // Center(
            //     child: SizedBox(
            //         width: 20,
            //         height: 20,
            //         child: CircularProgressIndicator(
            //             strokeWidth: 2,
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 ColorSelect.mainColor))))
          ],
        ),
      ),
    );
  }
}
