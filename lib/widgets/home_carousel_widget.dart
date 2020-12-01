import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    double mHeight = mediaConst.size.height;
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CarouselSlider(
          items: [
            Image.network(
              "https://www.paldesk.com/wp-content/uploads/2019/08/ecommerce-marketing-strategies-stand-out-from-the-competition-1024x439.png",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://cdn.wedevs.com/uploads/2020/01/Forecasting-the-future-of-eCommerce.png",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://www.hostgator.com/blog/wp-content/uploads/2020/04/How-Has-Ecommerce-Transformed-Marketing@2x.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://cdn.wedevs.com/uploads/2020/01/Forecasting-the-future-of-eCommerce.png",
              fit: BoxFit.cover,
            ),
          ],
          options: CarouselOptions(
            height: mHeight * 0.2,
            autoPlay: true,
            autoPlayCurve: Curves.easeInBack,
            autoPlayInterval: Duration(seconds: 5),
          ),
        ),
      ),
    );
  }
}
