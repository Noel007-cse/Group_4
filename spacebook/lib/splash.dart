import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashframeWidget extends StatelessWidget {
  const SplashframeWidget({super.key});

          @override
          Widget build(BuildContext context) {
          // Figma Flutter Generator SplashframeWidget - FRAME - VERTICAL
            return Container(
      decoration: BoxDecoration(
          color : Color.fromRGBO(248, 249, 250, 1),
  ),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
        width: 348,
        height: 40,
        decoration: BoxDecoration(
          
  )
      ), SizedBox(height : 0),
Container(
        width: 128,
        height: 6,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(9999),
            topRight: Radius.circular(9999),
            bottomLeft: Radius.circular(9999),
            bottomRight: Radius.circular(9999),
          ),
      color : Color.fromRGBO(203, 213, 225, 1),
  )
      ), SizedBox(height : 0),
Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
      decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
      color : Color.fromRGBO(255, 255, 255, 1),
      border : Border.all(
          color: Color.fromRGBO(243, 244, 246, 1),
          width: 1,
        ),
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          Container(
      decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
      color : Color.fromRGBO(255, 255, 255, 1),
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[SvgPicture.asset(
        'assets/icon.svg',
        semanticsLabel: 'icon'
      ),
],
      ),
    ),

        ],
      ),
    ), SizedBox(width : 0),
Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
      boxShadow : [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
          offset: Offset(0,8),
          blurRadius: 10
      )],
      color : Color.fromRGBO(255, 255, 255, 0.0020000000949949026),
  )
      ),

        ],
      ),
    ),
],
      ),
    ), SizedBox(height : 0),
Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Text('SpaceBook', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(15, 23, 42, 1),
        fontFamily: 'Inter',
        fontSize: 32,
        letterSpacing: -0.8999999761581421,
        fontWeight: FontWeight.normal,
        height: 1.25
      ),),
],
      ),
    ), SizedBox(height : 8),
Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Text('Book spaces, find your place.', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(100, 116, 139, 1),
        fontFamily: 'Inter',
        fontSize: 16,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 1.5
      ),),
],
      ),
    ),
],
      ),
    ),
],
      ),
    ),
],
      ),
    ),
],
      ),
    );
          }
        }
        