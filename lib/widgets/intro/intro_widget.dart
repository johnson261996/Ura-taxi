import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/images.dart';
import 'package:ura_taxi/resources/strings.dart';
import 'package:ura_taxi/routes/routes.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions:  <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, Routes.login);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: Text('Skip', style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: Images.Intro_Img1,
                  title: Strings.IntroTitle,
                  content: Strings.Intro_SubTitle
              ),
              makePage(
                  reverse: false,
                  image:  Images.Intro_Img2,
                  title: Strings.IntroTitle,
                  content: Strings.Intro_SubTitle
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
         // SizedBox(height: 10,),
          Container(
            width: mediaQuery.width * 0.9,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              child: const Text('Get Started'),
              onPressed: () {
                 Navigator.pushReplacementNamed(context, Routes.login);
              },
              style: ElevatedButton.styleFrom(
                  primary:const Color(0xff804ed1),
                  //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse ?
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(height: 30,),
            ],
          ) : SizedBox(),
          Text(title, style: const TextStyle(
              color: Colors.grey,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Text(content, textAlign: TextAlign.center, style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400
          ),),
          reverse ?
          Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ) :const SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin:const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<2; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
