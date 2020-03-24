import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/account/signin.dart';
import '../screens/profile.dart';
import '../services/auth.dart';

getAppBar(
    {@required GlobalKey<ScaffoldState> scaffoldKey,
    @required BuildContext context,
    @required String strAppBarTitle,
    @required bool showBackButton,
    TabBar tabBar}) {
  double size = MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
      ? MediaQuery.of(context).size.width
      : (!kIsWeb) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height / 2;

  return new AppBar(
    iconTheme: IconThemeData(color: Colors.grey),
    elevation: 0,
    titleSpacing: 0.0,
    centerTitle: true,
    backgroundColor: myAppTheme.backgroundColor,
    bottom: tabBar,
    leading: showBackButton
        ? IconButton(
            icon: Icon(Icons.arrow_back_ios, color: myAppTheme.iconTheme.color, size: myAppTheme.iconTheme.size),
            onPressed: () => Navigator.of(context).pop())
        : IconButton(
            icon: Icon(Icons.menu, color: myAppTheme.iconTheme.color, size: myAppTheme.iconTheme.size),
            onPressed: () => scaffoldKey.currentState.openDrawer()),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //Title
        Text(
          strAppBarTitle,
          style: myAppTheme.textTheme.display1,
          textAlign: TextAlign.center,
        ),

        //Profile
        userProfile.containsKey("photo url")
            ? InkWell(
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: size * 0.14,
                  width: size * 0.14,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userProfile["photo url"]),
                    minRadius: 90,
                    maxRadius: 180,
                  ),
                ),
                onTap: () => _checkLoggedInUser(context)
        )
            : Center(
                child: IconButton(
                    icon: Icon(Icons.account_circle),
                    iconSize: size * 0.07,
                    onPressed: () => _checkLoggedInUser(context)
                ),
              ),
      ],
    ),
  );
}

_checkLoggedInUser(BuildContext context) {
  //For mobile
  if (blIsSignedIn) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  } else {
    //Redirect to SignIn screen
    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignInScreen()), (Route<dynamic> route) => false);
  }
}
