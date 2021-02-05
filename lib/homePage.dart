import 'package:flutter/material.dart';
import 'package:testDemo/triangle.dart';
import 'package:testDemo/user_model.dart';
import 'package:testDemo/user_presenter.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements GetUserinfoListener {
  GetUserinfoPresenter _getUserinfoPresenter;
  List<User> aList = [];
  math.Random random = new math.Random();
  ScrollController _scrollController = ScrollController();
  List<User> aListUser = [];
  List<User> aListUser1 = [];
  List<User> aListUser2 = [];
  List<User> aListUser3 = [];
  List<User> aListUser4 = [];
  List<User> aListUser5 = [];
  bool isShowSnackbar = true;
  bool isHidden = false;
  List imageList = [
    "assets/images1.jpeg",
    "assets/images2.jpeg",
    "assets/images3.jpeg",
    "assets/images4.jpeg",
    "assets/images6.jpeg",
    "assets/images3.jpeg",
    "assets/images4.jpeg",
    "assets/images2.jpeg",
    "assets/images3.jpeg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserinfoPresenter = GetUserinfoPresenter(this);
    _getUserinfoPresenter.getuserInfo();
    _scrollController.addListener(() {
      if (isHidden != true) {
        isHidden = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          children: [
            // slidablebar
            _slidableBar(),
            // tabBar
            _tabbar(),
            SizedBox(
              height: 15,
            ),
            // bubbles
            _bubbles(),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationRow(),
    );
  }

// Floting Button
  _floatingActionButton() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 60,
            child: BubbleSpecialOne(
              text: "Do you want to set you intent?",
              isSender: true,
            ),
          ),
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Image.asset(
              "assets/duolingo.png",
            ),
          ),
        ],
      ),
    );
  }

// Slidable Bar
  _slidableBar() {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return Stack(
          children: [
            isHidden
                ? Container()
                : Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Container(
                              height: 60,
                              width: 60,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: aList.length,
                itemBuilder: (context, index) {
                  return _userUISe(
                    aList[index],
                    isSelected: true,
                    isBoder: index == 1 ? true : false,
                  );
                },
              ),
            ),
          ],
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        // Add the profile in slider bar
        try {
          int id = int.parse(data);
          for (var i = 0; i < aListUser.length; i++) {
            User element = aListUser[i];
            if (element.id == id) {
              aList.add(element);
              break;
            }
          }
        } catch (e) {
          print(e);
        }
        setState(() {});
      },
    );
  }

// slider bar user UI
  _userUISe(
    element, {
    bool isSelected = false,
    bool isBoder = false,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(
                    color: isBoder ? Colors.green : Colors.transparent),
                image: DecorationImage(
                  image: AssetImage(
                    element.image,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(bottom: 13, right: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabbar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 60),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Dates",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Mates",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// bubbles UI
  Widget _bubbles() {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row(aListUser5),
                    Container(
                      margin: EdgeInsets.only(left: 70),
                      child: _row(aListUser1),
                    ),
                    _row(aListUser2),
                    _row(aListUser3),
                    _row(aListUser4),
                  ],
                ),
              ),
            ),
          ),
          // Snack bar
          isShowSnackbar
              ? Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding:
                      EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 40,
                        ),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("We have 66 matches for you today"),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          isShowSnackbar = false;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _row(List<User> aTListUser) {
    List<Widget> aTlist = [];
    aTListUser.forEach((element) {
      aTlist.add(
        LongPressDraggable(
          dragAnchor: DragAnchor.pointer,
          data: element.id.toString(),
          childWhenDragging: Container(),
          feedback: _userUI(element),
          child: _userUI(element),
        ),
      );
    });
    return Row(
      children: aTlist,
    );
  }

  _userUI(
    element, {
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 140,
      width: 140,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: Image.asset(
          element.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// bottom Navigation bar
  _bottomNavigationRow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 10,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _bottomBtn(
              title: "Explore",
              ontap: () {},
              icon: Icons.search,
              isSelected: true,
            ),
            _bottomBtn(
              title: "Connections",
              ontap: () {},
              icon: Icons.message,
              isSelected: false,
            ),
            _bottomBtn(
              title: "Experience",
              ontap: () {},
              icon: Icons.star_outline,
              isSelected: false,
            ),
            _bottomBtn(
              title: "Dates",
              ontap: () {},
              icon: Icons.calendar_today,
              isSelected: false,
            ),
            _bottomBtn(
              title: "Dashboard",
              ontap: () {},
              icon: Icons.person,
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }

  _bottomBtn({
    String title,
    Function() ontap,
    IconData icon,
    bool isSelected = false,
  }) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 2,
              color: isSelected ? Colors.green : Colors.transparent,
            ),
            Expanded(
              child: Icon(
                icon,
                color: isSelected ? Colors.green : Colors.grey,
              ),
            ),
            Container(
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

// API Call Response
  @override
  void showData({msg, aUser}) {
    // TODO: implement showData

    for (var i = 0; i < aUser.length; i++) {
      User element = aUser[i];
      element.image = imageList[random.nextInt(4)];
      aListUser.add(element);
    }

    var tempDataList = [];
    for (var i = 0; i < aListUser.length; i += 10) {
      tempDataList.add(aListUser.sublist(
          i, i + 10 > aListUser.length ? aListUser.length : i + 10));
    }

    aListUser1.addAll(tempDataList[0]);
    aListUser2.addAll(tempDataList[1]);
    aListUser3.addAll(tempDataList[2]);
    aListUser4.addAll(tempDataList[3]);
    aListUser5.addAll(tempDataList[4]);

    // aListUser = aUser;
    setState(() {});
  }

  @override
  void showMSG(msg) {
    // TODO: implement showMSG
  }
}
