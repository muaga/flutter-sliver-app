import 'package:flutter/material.dart';

class MyThirdSliver extends StatelessWidget {
  const MyThirdSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // 찢어진 조각이라서 container가 그냥 들어가지 않는다.
      slivers: [
        SliverAppBar(
          title: Text("SliverAppber"),
          expandedHeight: 200, // flexibleSpace가 사용할 높이
          flexibleSpace: Container(
            // FlexibleSpaceBar를 사용하여 배경을 사진으로 두면, 스크롤을 통해 해당 appbar를 보이지 않도록
            // 올릴 때, 원래의 배경 컬러로 보인다.
            // Container을 사용하여 배경을 사진으로 두면, 스크롤을 통해 해당 appbar를 보이지 않도록 올릴 때,
            // 사진을 끝까지 유지한다.
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("http://picsum.photos/200/300"),
                fit: BoxFit.cover,
              ),
            ),
            // background: Image.network(
            //   "http://picsum.photos/200/300",
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        SliverToBoxAdapter(
          // 해당 box 안의 item을 sliver 타입으로 변환
          child: Container(
            height: 500,
            color: Colors.red,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            // for문
            childCount: 5,
            (context, index) {
              return Padding(
                // childCount의 갯수만큼 for문 돌 때
                // viewholder 패턴을 사용한다.
                // 틀을 만들어서, 스크롤을 내릴 때(화면보이게) 마다
                // 틀은 재 사용 -> 데이터만 바꿔준다.
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                    height: 100, color: Colors.blue, child: Text("${index}")),
              );
            },
          ),
        ),
        // 수평 스크롤 가능한 ListView
        SliverToBoxAdapter(
          child: SizedBox(
            height: 150, // ListView의 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 수평 스크롤 설정
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: Text("Horizontal Item $index"),
                );
              },
            ),
          ),
        ),
        SliverFillViewport(
            // 화면 꽉 채우는 ListView
            // 광고할 때 많이 사용한다.
            delegate: SliverChildBuilderDelegate(
          childCount: 5,
          (context, index) {
            return Card(
              child: Container(
                child: Text("Fill ViewPort Item ${index}"),
              ),
            );
          },
        )),
      ],
    );
  }
}
