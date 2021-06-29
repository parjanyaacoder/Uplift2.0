import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

mixin BulbColor{
  static const redColor = Vx.red600;
  static const blueColor = Vx.blueGray600;
}

class AppScreen extends StatefulWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {

  AnimationController animationController;
  Animation<int> stringCounter;
  static  String welcomeString = "I cannot see anything. It's too dark. Can you please switch on the light bulb in the room.";
  bool lightOn = false;
  Color color ;
  CurvedAnimation curvedAnimation;
  Animation<Offset> _translationAnim;
  Animation<Offset> _moveAnim;
  Animation<double> _scaleAnim;
  Animation offsetAnimation;
  AnimationController animationController2;

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
  color = Vx.gray200;
  animationController2 = new AnimationController(vsync: this,duration: Duration(seconds: 3));
  animationController = new AnimationController(vsync: this,
    duration: Duration(seconds: 8),
  );

  stringCounter = StepTween(begin: 0,end: welcomeString.length).animate(CurvedAnimation(parent: animationController, curve: Curves.linear))
  ..addStatusListener((state) {
    if(state == AnimationStatus.completed){}
  })
  ..addListener(() {
    setState(() {
    });
  });
  offsetAnimation = Tween(begin: Offset(-1000.0, 0.0), end: Offset(0.0, 0.0)).animate(CurvedAnimation(
    parent: animationController2,
    curve: Curves.easeIn,
  ));

  curvedAnimation = CurvedAnimation(
      parent: animationController2,
      curve: Curves.easeIn,);
  _translationAnim = Tween(begin: Offset(-1000.0, 0.0), end: Offset(0.0, 0.0))
      .animate(animationController2)
    ..addListener(() {
      setState(() {});
    });
  _scaleAnim = Tween(begin: 0.920, end: 1.0).animate(curvedAnimation);
  _moveAnim = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, 0.0))
      .animate(curvedAnimation);


   animationController.forward().then((value) =>
      animationController2.forward());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !lightOn ? Vx.gray800 : Vx.white,
      body: VStack([
        "${welcomeString.substring(0,stringCounter.value)}".text.color(!lightOn ? Vx.white : Vx.gray600 ).xl2.make().box.make().p32(),

           Icon( !lightOn ? Icons.lightbulb_outline : Icons.lightbulb,color: lightOn ? color : Vx.gray800,).iconSize(60),
            20.heightBox,
            Transform.translate(
            offset: _translationAnim.value,
    child: FractionalTranslation(
    translation: _moveAnim.value,
    child: Transform.scale(
    alignment: Alignment.topCenter,
    scale: _scaleAnim.value,
    child:ElevatedButton(onPressed: () async {
      lightOn = !lightOn;
      await Future.delayed(Duration(seconds: 1),(){welcomeString = lightOn ? "Haaaaa... I can see you now." : "I cannot see anything. It's too dark. Can you please switch on the light bulb in the room.";
      });
      setState(() {

                         stringCounter  =  StepTween(begin: 0,end: welcomeString.length).animate(CurvedAnimation(parent: animationController, curve: Curves.linear))
                   ..addStatusListener((state) {
                     if(state == AnimationStatus.completed){}
                   })
                   ..addListener(() {
                     setState(() {
                     });
                   });
                 animationController.reset();
                 animationController.forward();
               });
           }, child: "Turn On".text.size(12.0).make()).w20(context),
            ),),),
           20.heightBox,
        Transform.translate(
          offset: _translationAnim.value,
          child: FractionalTranslation(
              translation: _moveAnim.value,
              child: Transform.scale(
                  alignment: Alignment.topCenter,
                  scale: _scaleAnim.value,
                  child:
             ElevatedButton(onPressed: (){
               setState(() {
                 color = BulbColor.redColor;
               });
             }, child: "Red".text.size(12.0).make()).w20(context),
           ),),),
           20.heightBox,
           Transform.translate(
           offset: _translationAnim.value,
    child: FractionalTranslation(
    translation: _moveAnim.value,
    child: Transform.scale(
    alignment: Alignment.topCenter,
    scale: _scaleAnim.value,
    child: ElevatedButton(onPressed: (){
               setState(() {
                 color = BulbColor.blueColor;
               });
             }, child: "Blue".text.size(12.0).make()).w20(context),
           ),),),
      ], alignment: MainAxisAlignment.center,crossAlignment: CrossAxisAlignment.center,).scrollVertical().centered(),
    );
  }
}

