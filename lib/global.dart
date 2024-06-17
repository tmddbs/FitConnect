class Person {
  String name; //이름
  String tag; // 태그
  String intro; //한마디
  double today_kilo; //오늘 든 무게
  double week_kilo; //이번 주 든 무게
  double todayCalories; //오늘 칼로리
  double weekCalories; //이번 주 칼로리
  String address; //주소
  String profileImage; //이미지

  Person({
    required this.name,
    required this.tag,
    required this.intro,
    required this.today_kilo,
    required this.week_kilo,
    required this.todayCalories,
    required this.weekCalories,
    required this.address,
    required this.profileImage,
  });
}

class MyData extends Person {
  MyData()
      : super(
          name: '나',
          tag: 'hero',
          intro: '안녕하세요, 저는 김민수입니다. 헬스 하는걸 좋아해요',
          today_kilo: 0.0,
          week_kilo: 490.0, // 예시로 하루 70kg 들면 주 490kg
          todayCalories: 0.0,
          weekCalories: 1000.0,
          address: '',
          profileImage: '프로필1.png',
        );
}

class Person1 extends Person {
  Person1()
      : super(
          name: '김영희',
          tag: 'friend',
          intro: '안녕하세요, 저는 김영희입니다.',
          today_kilo: 65.0,
          week_kilo: 455.0, // 예시로 하루 65kg 들면 주 455kg
          todayCalories: 1800.0,
          weekCalories: 12600.0,
          address: '안성시 대덕면',
          profileImage: '프로필2.png',
        );
}

class Person2 extends Person {
  Person2()
      : super(
          name: '이철수',
          tag: 'colleague',
          intro: '안녕하세요, 저는 이철수입니다.',
          today_kilo: 75.0,
          week_kilo: 525.0, // 예시로 하루 75kg 들면 주 525kg
          todayCalories: 2200.0,
          weekCalories: 15400.0,
          address: '안성시 공도읍',
          profileImage: '프로필3.png',
        );
}

// 추가할 사람들 정의
class Person3 extends Person {
  Person3()
      : super(
          name: '박상민',
          tag: 'gym buddy',
          intro: '안녕하세요, 저는 박상민입니다.',
          today_kilo: 80.0,
          week_kilo: 560.0,
          todayCalories: 2300.0,
          weekCalories: 16100.0,
          address: '안성시 원곡면',
          profileImage: '마커.png',
        );
}

class Person4 extends Person {
  Person4()
      : super(
          name: '최수정',
          tag: 'mentor',
          intro: '안녕하세요, 저는 최수정입니다.',
          today_kilo: 50.0,
          week_kilo: 350.0,
          todayCalories: 150.0,
          weekCalories: 10500.0,
          address: '안성시 죽산면',
          profileImage: '프로필1.png',
        );
}

class Person5 extends Person {
  Person5()
      : super(
          name: '한지민',
          tag: 'trainer',
          intro: '안녕하세요, 저는 한지민입니다.',
          today_kilo: 90.0,
          week_kilo: 630.0,
          todayCalories: 2500.0,
          weekCalories: 17500.0,
          address: '안성시 삼죽면',
          profileImage: '프로필2.png',
        );
}

class Person6 extends Person {
  Person6()
      : super(
          name: '서준호',
          tag: 'newbie',
          intro: '안녕하세요, 저는 서준호입니다.',
          today_kilo: 30.0,
          week_kilo: 210.0,
          todayCalories: 100.0,
          weekCalories: 8400.0,
          address: '안성시 공도읍',
          profileImage: '프로필3.png',
        );
}

class Person7 extends Person {
  Person7()
      : super(
          name: '이유진',
          tag: 'enthusiast',
          intro: '안녕하세요, 저는 이유진입니다.',
          today_kilo: 70.0,
          week_kilo: 490.0,
          todayCalories: 2000.0,
          weekCalories: 14000.0,
          address: '안성시 아양동',
          profileImage: '마커.png',
        );
}

// 전역 변수로 MyData와 다른 인스턴스 생성
MyData globalMyData = MyData();
Person1 globalPerson1 = Person1();
Person2 globalPerson2 = Person2();
Person3 globalPerson3 = Person3();
Person4 globalPerson4 = Person4();
Person5 globalPerson5 = Person5();
Person6 globalPerson6 = Person6();
Person7 globalPerson7 = Person7();

List<Person> getSortedPersonsBytodyaCalories() {
  List<Person> persons = [
    globalMyData,
    globalPerson1,
    globalPerson2,
    globalPerson3,
    globalPerson4,
    globalPerson5,
    globalPerson6,
    globalPerson7,
  ];

  persons.sort((a, b) => b.todayCalories.compareTo(a.todayCalories));
  print(persons);
  return persons;
}
