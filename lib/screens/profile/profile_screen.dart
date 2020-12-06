import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'favourites_screen.dart';

class ProfileScreen extends StatelessWidget {
  ThemeData themeConst;
  double mHeight, mWidth;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    mHeight = mediaConst.size.height;
    mWidth = mediaConst.size.width;
    themeConst = Theme.of(context);
    return ListView(
      children: [
        Stack(children: [
          Container(
            height: mHeight * 0.3,
            color: themeConst.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          "https://media-exp1.licdn.com/dms/image/C5603AQFg5BiOfRrjcA/profile-displayphoto-shrink_200_200/0/1596812566436?e=1612396800&v=beta&t=VhCNzkJSCU104yW4n3ANQFiXI4QoaVjmppPp8Nl9Ang"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Samip Gyawali",
                    style: themeConst.textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "samipgyawali15@gmail.com",
                    style: themeConst.textTheme.caption.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ]),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.edit,
            color: Colors.green.shade400,
          ),
          title: Text(
            "Edit Profile",
            style: themeConst.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.boxes,
            color: themeConst.accentColor,
          ),
          title: Text(
            "My Orders",
            style: themeConst.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, FavouritesScreen.routeName);
          },
          leading: Icon(
            FontAwesomeIcons.solidHeart,
            color: Colors.blue.shade600,
          ),
          title: Text(
            "Favourites",
            style: themeConst.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.red.shade400,
          ),
          title: Text(
            "Logout",
            style: themeConst.textTheme.subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
