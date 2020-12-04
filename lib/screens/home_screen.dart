import 'package:chito_shopping/screens/product/product_list_screen.dart';
import 'package:chito_shopping/widgets/home_carousel_widget.dart';
import 'package:chito_shopping/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  ThemeData themeConst;
  double mHeight, mWidth;

  Widget _getCategoryItems(
      {@required String title,
      @required IconData icon,
      @required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: mHeight * 0.07,
            width: mWidth * 0.15,
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [color.withOpacity(0.7), color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            )),
        SizedBox(
          height: mHeight * 0.01,
        ),
        Text(title)
      ],
    );
  }

  Widget _getTitleWidget({@required String title, @required Function onPress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: themeConst.textTheme.headline5
                .copyWith(fontWeight: FontWeight.w600)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: onPress,
                child: Text("All", style: TextStyle(fontSize: 15))),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    mHeight = mediaConst.size.height;
    mWidth = mediaConst.size.width;
    themeConst = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
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
                    icon: FontAwesomeIcons.tshirt,
                    title: "Clothing",
                  ),
                  _getCategoryItems(
                      color: Colors.green,
                      icon: FontAwesomeIcons.laptop,
                      title: "Electronics"),
                  _getCategoryItems(
                      color: Colors.blue,
                      icon: FontAwesomeIcons.couch,
                      title: "Furniture"),
                  _getCategoryItems(
                      color: Colors.purple,
                      icon: FontAwesomeIcons.baseballBall,
                      title: "Sports"),
                ],
              ),
              SizedBox(
                height: mHeight * 0.03,
              ),
              _getTitleWidget(
                  title: "Flash Sale",
                  onPress: () {
                    Navigator.pushNamed(context, ProductListScreen.routeName,
                        arguments: "Flash Sale");
                  }),
              Container(
                height: mHeight * 0.22,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductItem(
                      title: "Shirt",
                      price: 1500,
                      imgUrl:
                          "https://www.fashionbug.lk/wp-content/uploads/2020/01/080201606669-C2_Formal-Shirt-2_Fashion-Bug.jpg",
                    ),
                    ProductItem(
                      title: "Pant",
                      price: 1800,
                      imgUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkWMvIAG8Tm23dlrAmesX_UJ2vcDoPxbIDfg&usqp=CAU",
                    ),
                    ProductItem(
                      title: "Shoes",
                      price: 2000,
                      imgUrl:
                          "https://assets.ajio.com/medias/sys_master/root/ajio/catalog/5ef38fcbf997dd433b43d714/-473Wx593H-461205998-black-MODEL.jpg",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mHeight * 0.02,
              ),
              _getTitleWidget(
                  title: "New Product",
                  onPress: () {
                    Navigator.pushNamed(context, ProductListScreen.routeName,
                        arguments: "New Product");
                  }),
              Container(
                height: mHeight * 0.22,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductItem(
                      title: "Santizer",
                      price: 150,
                      imgUrl:
                          "https://img.my-best.in/press_eye_catches/55edb55bf88bb49f81f55e0e33e64b6e.jpg",
                    ),
                    ProductItem(
                      title: "JBL Speakers",
                      price: 1500,
                      imgUrl:
                          "https://target.scene7.com/is/image/Target/GUEST_199cec2b-f33d-4ef0-a7cd-d3e22b42f0fe?wid=488&hei=488&fmt=pjpeg",
                    ),
                    ProductItem(
                      title: "Google Home",
                      price: 5000,
                      imgUrl:
                          "https://i5.walmartimages.com/asr/a55c9d64-74bb-4706-9a7e-12b012c98fa6.3dc3a5b67256ba156e1c40a865f8eea2.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
