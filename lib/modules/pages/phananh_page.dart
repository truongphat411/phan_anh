import 'package:flutter/material.dart';
import 'package:phan_anh/modules/providers/phananh_provider.dart';
import 'package:provider/provider.dart';

class PhanAnhPage extends StatefulWidget {
  const PhanAnhPage({Key? key}) : super(key: key);

  @override
  State<PhanAnhPage> createState() => _PhanAnhPageState();
}

class _PhanAnhPageState extends State<PhanAnhPage> {
  PhanAnhProvider provider = PhanAnhProvider();
  @override
  void initState() {
    super.initState();
    provider.firstLoad();
    provider.getLoaiPAList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Xử lý phản ánh',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Consumer<PhanAnhProvider>(
          builder: (context, value, child) {
            final list = provider.itemListLPA;
            final current = provider.currentIndex;
            return provider.isFirstLoadRunning || provider.isFilterLoadRunning == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(5),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 60,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: list.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          provider.updateCurrent(index);
                                          provider.getFilter(list[index].loaiPhanAnhId ?? 0);
                                          provider.updateIsFilterLoadingRunngin(false);
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: current == index
                                                ? Colors.white70
                                                : Colors.white54,
                                            borderRadius: current == index
                                                ? BorderRadius.circular(10)
                                                : null,
                                            border: current == index
                                                ? Border.all(
                                                    color: Colors.black,
                                                    width: 1)
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              list[index].tenLoaiPhanAnh ?? '',
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                        /// MAIN BODY
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.itemList.length,
                            itemBuilder: (context, index) {
                              return itemPhanAnh(
                                  context: context,
                                  index: index,
                                  provider: provider);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget itemPhanAnh(
      {required BuildContext context,
      required int index,
      required PhanAnhProvider provider}) {
    final item = provider.itemList[index];
    final listTepDinhKem = List.generate(item.tepDinhKems!.length, (index) {
      return Row(
        children: [
        ],
      );
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.error,color: Colors.white,
                ),
              ),
              Row(
                children: [
                  const Text('Ngày phản ánh:'),
                  Text(item.ngayPhanAnh!)
                ],
              ),
              Row(
                children: [
                  const Text('Địa chỉ:'),
                  Text(item.diaChi!)
                ],
              ),
              Row(
                children: [
                  const Text('Hành vi vi phạm:'),
                  Text(item.loaiViPham!.tenLoaiViPham!)
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                  child: Text('Nội dung phản ánh')),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(item.noiDung!)),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child: const Text(
                        'NỘI DUNG XỬ LÝ'
                      ),
                    ),
                    Column(
                      children: listTepDinhKem,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
