import 'package:flutter/material.dart';

class MySecondSliver extends StatelessWidget {
  const MySecondSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ListView upgrade 버전

    return CustomScrollView(
      // 찢어진 조각이라서 container가 그냥 들어가지 않는다.
      slivers: [
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
      ],
    );
  }
}
