import 'package:flutter/material.dart';
import 'package:phan_anh/modules/providers/bottom_sheet_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

//typedef ButtonAcceptCallback = void Function(Filter filter);

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  //final ButtonAcceptCallback onPressed;

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  final BottomSheetProvider _bottomSheetPAProvider = BottomSheetProvider();
  DateRangePickerController dateRangePickerController = DateRangePickerController();

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
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                onCancel: () {
                  Navigator.of(context).pop();
                },
                rangeSelectionColor: Colors.green,
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
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _bottomSheetPAProvider.getLoaiPAList();
    _bottomSheetPAProvider.getPXList();
  }

  @override
  Widget build(BuildContext context) {
    final double widthItem = MediaQuery.of(context).size.width / (2 * 100);
    return ChangeNotifierProvider(
      create: (_) => _bottomSheetPAProvider,
      child: Consumer<BottomSheetProvider>(
        builder: (context, provider, child) {
          return SizedBox(
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
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
                          right: 5,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.highlight_remove,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white70),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(20),
                      child: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: provider.tenloaiPA,
                            items: provider.loaiPAList
                                .map((value) => DropdownMenuItem<String>(
                              value: value.loaiPhanAnhId.toString(),
                              child: Text(value.tenLoaiPhanAnh!,
                                  style: const TextStyle(
                                      color: Colors.black)),
                            ))
                                .toList(),
                            onChanged: (value) {
                              print('PhatNMT: $value');
                              provider.getLoaiVPList(int.parse(value!));
                              provider.setTenLoaiPA(value);
                            },
                          ),
                        ),
                      )),
                  Visibility(
                    visible: provider.loaiVPList.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          shrinkWrap: true,
                          itemCount: provider.loaiVPList.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: widthItem,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                provider.loaiVPList[index].selected =
                                !provider.loaiVPList[index].selected;
                                provider.updateLoaiVPList(provider.loaiVPList);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                    provider.loaiVPList[index].selected ==
                                        true
                                        ? Colors.green
                                        : Colors.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Center(
                                    child: Text(
                                      provider.loaiVPList[index].tenLoaiViPham!,
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.clip,
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white70),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(20),
                      child: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: provider.phuongXaId,
                            items: provider.pxList
                                .map((value) => DropdownMenuItem<String>(
                              value: value.phuongXaId.toString(),
                              child: Text(value.tenPhuongXa!,
                                  style: const TextStyle(
                                      color: Colors.black)),
                            ))
                                .toList(),
                            onChanged: (value) {
                              provider.setPhuongXaId(value);
                              provider.getDList(int.parse(value!));
                            },
                          ),
                        ),
                      )),
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white70),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(20),
                      child: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: provider.duongId,
                            items: provider.dList
                                .map((value) => DropdownMenuItem<String>(
                              value: value.duongId.toString(),
                              child: Text(value.tenDuong!,
                                  style: const TextStyle(
                                      color: Colors.black)),
                            ))
                                .toList(),
                            onChanged: (value) {
                              provider.setDuongId(value);
                            },
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              'Từ ngày ${provider.fromDate != null ? '${provider.fromDate?.day}-${provider.fromDate?.month}-${provider.fromDate?.year}' : ''} '
                                  'đến ngày ${provider.toDate != null ? '${provider.toDate?.day}-${provider.toDate?.month}-${provider.toDate?.year}' : ''}')),
                      GestureDetector(
                        onTap: () {
                          _showDatePicker(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child: Text('Chọn'),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.green),
                      child: const Center(
                        child: Text('Lọc'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
