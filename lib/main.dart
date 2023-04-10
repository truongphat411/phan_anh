import 'package:flutter/material.dart';
import 'package:phan_anh/modules/pages/pages.dart';
import 'package:phan_anh/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.mainColor,
        title: const Text('Xử lý phản ánh'),
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PhanAnhPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            decoration: BoxDecoration(
              color: ColorSelect.mainColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text('Xử lý', style: TextStyle(color: ColorSelect.primaryColor,fontWeight: FontWeight.bold),),
          ),
        )
      ),
    );
  }
}