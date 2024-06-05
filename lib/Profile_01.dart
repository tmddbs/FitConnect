import 'package:flutter/material.dart';

void showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 450.0, // 정사각형 모양을 위해 width와 height를 동일하게 설정
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/ping1.png', width: 80,height: 80,),
                    Column(
                    children: [
                      Row(
                        children: [
                          Text('이름'),
                          
                          Align(
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // 닫기 버튼 클릭 시 팝업 닫기
                              },
                              icon: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                      TextButton(onPressed: null, child: Text('#태그'),style: ButtonStyle(),),
                      Text('한마디'),

                      
                    ],
                    ),
                    
                  ],
                ),
                Divider(thickness: 1,),
                Column(
                  children: [
                    Text('금주의 활동',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    Text('32분',style: TextStyle(fontSize: 15,)),
                    Text('1503 Kcal',style: TextStyle(fontSize: 15,)),
            
                  ],
                )
              ],
            ),
          ),
          // child: Column(
          //   children: [
          //     Image.asset('ping1.png', width: 10,height: 10,),
          //     Align(
          //       alignment: Alignment.topRight,
          //       child: IconButton(
          //         onPressed: () {
          //           Navigator.of(context).pop(); // 닫기 버튼 클릭 시 팝업 닫기
          //         },
          //         icon: Icon(Icons.close),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      );
    },
  );
}