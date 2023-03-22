import 'package:flutter/material.dart';
import 'package:phan_anh/modules/providers/phananh_provider.dart';
import 'package:provider/provider.dart';

import '../modules.dart';

class PhanAnhPage extends StatefulWidget {
  const PhanAnhPage({Key? key}) : super(key: key);

  @override
  State<PhanAnhPage> createState() => _PhanAnhPageState();
}

class _PhanAnhPageState extends State<PhanAnhPage> {
  PhanAnhProvider provider = PhanAnhProvider();
  int current = 0;
  @override
  void initState() {
    super.initState();
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
            return provider.isFirstLoadRunning == true ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ):Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
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
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 100),
                                    margin: const EdgeInsets.all(5),
                                    padding : const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    decoration: BoxDecoration(
                                      color: current == index
                                          ? Colors.white70
                                          : Colors.white54,
                                      borderRadius: current == index
                                          ? BorderRadius.circular(10)
                                          : BorderRadius.circular(10),
                                      border: current == index
                                          ? Border.all(
                                          color: Colors.deepPurpleAccent, width: 2)
                                          : Border.all(
                                          color: Colors.grey, width: 2),
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
                          })
                  ),
                  /// MAIN BODY
                  Container(
                    color: Colors.blue,
                    margin: const EdgeInsets.only(top: 30),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          list[current].tenLoaiPhanAnh ?? '',
                        ),
                      ],
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
}
