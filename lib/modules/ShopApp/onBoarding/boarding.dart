import 'package:flutter/material.dart';
import 'package:news/Network/local/cache_helper.dart';
import 'package:news/modules/ShopApp/Login/login.dart';
import 'package:news/shared/component/componentButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoradingModel {
  final String image;
  final String title;
  final String body;
  BoradingModel({this.image, this.body, this.title});
}

// ignore: must_be_immutable
class OnBoardinScreen extends StatefulWidget {
  @override
  _OnBoardinScreenState createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  List<BoradingModel> borading = [
    BoradingModel(
        image: 'assets/salah.jpg',
        body: 'On Borading 1 Body ',
        title: 'On Boarding 1 Title '),
    BoradingModel(
        image: 'assets/salah.jpg',
        body: 'On Borading 2 Body ',
        title: 'On Boarding 2 Title '),
    BoradingModel(
        image: 'assets/salah.jpg',
        body: 'On Borading 3 Body ',
        title: 'On Boarding 3 Title ')
  ];

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                  // navigateAndFinish(context, LoginScreen());
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == borading.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBordingitem(borading[index]),
                  itemCount: borading.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   "indicator",
                  // ),
                  SizedBox(
                    width: 40,
                  ),
                  SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 12,
                        activeDotColor: Colors.red,
                        spacing: 10,
                      ),
                      controller: boardController,
                      count: borading.length),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Center(child: Icon(Icons.arrow_forward_ios)),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBordingitem(BoradingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      );

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());

        print("save Value");
      }
    });
  }
}
