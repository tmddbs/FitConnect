// Profile.dart
import 'package:flutter/material.dart';
import 'global.dart';

void showPopup(BuildContext context, Person person) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 450.0,
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/marker/' + person.profileImage,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(person.name),
                            TextButton(
                              onPressed: null,
                              child: Text(person.tag),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                person.intro,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(thickness: 1),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '금일의 활동',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(person.today_kilo.toString() + 'kg',
                                style: TextStyle(fontSize: 15)),
                            Text(person.todayCalories.toString() + 'Kcal',
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        SizedBox(width: 50),
                        Column(
                          children: [
                            Text(
                              '금주의 활동',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(person.week_kilo.toString() + 'kg',
                                style: TextStyle(fontSize: 15)),
                            Text(person.weekCalories.toString() + ' Kcal',
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
