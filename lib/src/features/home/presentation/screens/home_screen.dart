import 'dart:math';

import 'package:ddd_framework_assets/shared/widgets/app_drawer_v2.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static MaterialPageRoute genRoute () {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => HomeScreen());
  }
  const  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dimension = 200;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawerV2(tiles: [
       {"label": "MyFeatureScreen.routeLabel", "path": "MyFeatureScreen.routeName"},
      ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
        foregroundColor: Colors.white,
          flexibleSpace: Container(

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 2),
              gradient: LinearGradient(
                stops: [0.1, 0.3, 0.7, 0.9],
                colors: [
                  Colors.blue.shade600,
                  Colors.yellow.shade600,
                  Colors.purple.shade600,
                  Colors.green.shade600,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

          ),
          title: Text('Menus'),


            ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(40),
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                TappableContainer(
                  width: 100,
                  color: Colors.blue,
                  height: 100,
                  label: 'Example Tappablecontainer',
                  routeName: 'noroute',

                ),


              ],),
          ),
        ),
      ),

    );
  }
}

class TappableContainer extends StatelessWidget {

  final String label;
  final String routeName;
  final Color color;
  final double width;
  final double height;


   TappableContainer({super.key,
     required this.width, required this.height,
     required this.label, required this.routeName, required this.color});

  @override
  Widget build(BuildContext context) {
    final color = Colors.accents[Random().nextInt(Colors.accents.length)];

    return  InkWell(
      onTap: () {


        // if(Navigator.canPop(context))
        final  aa = ModalRoute.of(context)?.settings.name;
        print('isin ${aa}');
        Navigator.pushNamed(context, routeName);
      },
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
        tween: Tween<double>(begin: -1, end: 0),
        builder: (context, value, child) {
          return Transform(
            transform: Matrix4.rotationY(3.14 *value),


            child: Container(
              margin: EdgeInsets.all(10),

              decoration: BoxDecoration(
                image:  DecorationImage(

                  image: AssetImage('images/boy-on-quiz.webp'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      color.withOpacity(0.1),
                      BlendMode.dstATop),
                ),
                border: Border.all(color: color.shade400.withOpacity(.5), width: 2),
                borderRadius: BorderRadius.circular(10),

              ),

              alignment: Alignment.center,
              width: width,
              height: height,
              child: Text('$label',
                style: Theme.of(context).textTheme.headlineLarge
                ?.copyWith(color: color),),),
          );
        }
      ),
    );
  }
}

