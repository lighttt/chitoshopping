import 'package:carousel_slider/carousel_slider.dart';
import 'package:chito_shopping/widgets/home_carousel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Widget _getCategoryItems(
      {@required ThemeData themeConst,
      @required double mHeight,
      @required String title,
      @required IconData icon,
      @required Color color}) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [color.withOpacity(0.7), color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              icon,
              color: Colors.white,
            )),
        SizedBox(
          height: mHeight * 0.01,
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    double mHeight = mediaConst.size.height;
    double mWidth = mediaConst.size.width;
    ThemeData themeConst = Theme.of(context);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: mHeight * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(
                height: mHeight * 0.015,
              ),
              HomeCarouselWidget(),
              SizedBox(
                height: mHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getCategoryItems(
                      color: themeConst.primaryColor,
                      icon: Icons.home,
                      mHeight: mHeight,
                      themeConst: themeConst,
                      title: "Man"),
                  _getCategoryItems(
                      color: Colors.green,
                      icon: Icons.home,
                      mHeight: mHeight,
                      themeConst: themeConst,
                      title: "Woman"),
                  _getCategoryItems(
                      color: Colors.blue,
                      icon: Icons.home,
                      mHeight: mHeight,
                      themeConst: themeConst,
                      title: "Kids"),
                  _getCategoryItems(
                      color: Colors.purple,
                      icon: Icons.home,
                      mHeight: mHeight,
                      themeConst: themeConst,
                      title: "Home"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
