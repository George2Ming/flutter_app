import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/my_page.dart';
import 'package:myapp/pages/search_page.dart';
import 'package:myapp/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>{
  // 页面控制
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final _defaultColor = Colors.grey; // 默认颜色
  final _activeColor = Colors.blue; // 激活颜色
  int _currentIndex = 0; // 当前索引
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          MyPage(),
          SearchPage(),
          TravelPage()
        ],
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,// 一直显示下面的文字
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _defaultColor),
          activeIcon: Icon(
            Icons.home,
            color: _activeColor,
          ),
          title: Text('首页',style: TextStyle(
            color: _currentIndex !=0 ? _defaultColor: _activeColor
          ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor),
            activeIcon: Icon(Icons.search, color: _activeColor),
            title: Text('搜索',style: TextStyle(
                color: _currentIndex !=1 ? _defaultColor: _activeColor
            ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: _defaultColor),
            activeIcon: Icon(Icons.camera_alt, color: _activeColor),
            title: Text('旅拍',style: TextStyle(
                color: _currentIndex !=2 ? _defaultColor: _activeColor
            ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text('我的',style: TextStyle(
                color: _currentIndex !=3 ? _defaultColor: _activeColor
            ),)
        )]
      ),
    );
  }

}
