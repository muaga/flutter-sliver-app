import 'package:flutter/material.dart';
import 'package:flutter_sliver_app2/mysliver/my_third_sliver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyThirdSliver(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  double prev = 0;
  double height = 300;
  double opacity = 1.0;
  double fontSize = 110;

  @override
  void initState() {
    _controller.addListener(() {
      scrollListener();
    });
    super.initState();
  }

  void scrollListener() {
    print("스크롤 동작중");
    double currentOffset = _controller.offset; // bar의 위치

    // 스크롤 방향을 알기 위해서는, bar의 현재 변수와 이전 변수를 알아야 한다.
    // bar의 변수는 0 ~ 300이라고 가정하면, 현재 변수가 이전 변수보다 작아지면
    // 스크롤이 올라가고 있는 것이다.

    // 실습

    if (currentOffset < 300) {
      setState(() {
        // app 높이는 남기는 방법
        height = 300 - currentOffset;
        // fontSize ... 이건 노동...
        fontSize = (height + 150) / 4;
        // container color
        opacity = (300 - currentOffset) / 300;

        // 최소값 만드는 방법
        if (height <= 56) {
          height = 56;
          fontSize = 50;
        }

        // 모두 없애는 방법
        // if로 음수 발생 시 오류 막기
        // height = 244 - currentOffset;
        // if (height < 56) {
        //   height = 0;
        // }
        print("height : ${height}");
        print("current : ${currentOffset}");
        print("opacity : ${opacity}");
        print("fontSize : ${fontSize}");
      });

      // if (0.1 <= opacity || opacity <= 1.0) {

      // }
    }

    // 301             300 => 스크롤 방향 아래로(최대로)
    if (currentOffset > prev) {
      print("아래로 내려가요");
    }

    // 300             301 => 스크롤 방향 위로(0으로)
    if (currentOffset < prev) {
      print("위로 올라가요");
    }

    // maxScrollExtent = 가장 하단
    if (currentOffset == _controller.position.maxScrollExtent) {
      print("가장 하단 : ${currentOffset}");
    }

    // mixScrollExtent = 가장 상단 = 0.0
    if (currentOffset == _controller.position.minScrollExtent) {
      // print("가장 상단 : ${currentOffset}");
    }

    prev = currentOffset; // 스크롤이 이동 시 이전 currentOffset = prev가 된다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(255, 0, 0, opacity),
              height: height,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Good",
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                // ListView에 원하는 Controller를 달면 감지한다.
                itemCount: 50,
                itemBuilder: (context, index) => Text("제목 $index"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
