import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final dummyItems = [
  'https://cdn.pixabay.com/photo/2020/04/22/09/59/tree-5077020_1280.jpg',
  'https://cdn.pixabay.com/photo/2020/04/27/11/03/ranunkeln-5099319__480.jpg',
  'https://cdn.pixabay.com/photo/2016/08/22/10/20/city-1611657_1280.jpg'
];

class UiEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UI 화면 예시')),
      body: ListView(
        children: <Widget>[
          _buildTop(),
          _buildMiddle(),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildTop() {
    Widget taxi() {
      return Column(
        children: <Widget>[
          Icon(
            Icons.local_taxi,
            size: 40,
          ),
          Text('택시'),
        ],
      );
    }

    Widget firstTaxt() {
      return GestureDetector(
        onTap: () {
          print('클릭');
        },
        child: taxi(),
      );
    }

    Widget secondTaxt() {
      return InkWell(
        onTap: () {
          print('클릭');
        },
        child: taxi(),
      );
    }

    final taxi1 = List<Widget>.generate(4, (index) => firstTaxt());
    final taxi2 = List<Widget>.generate(3, (index) => secondTaxt());

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: taxi1,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ...taxi2,
              Opacity(
                opacity: 0.0,
                child: taxi(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
      ),
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: BoxDecoration(color: Colors.amber),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom() {
    final items = List.generate(
      6,
      (index) => ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[공지] 이것은 공지사항입니다.'),
      ),
    );

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: items,
    );
  }
}
