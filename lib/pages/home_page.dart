import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myapp/dao/home_dao.dart';
import 'package:myapp/widget/grid_nav.dart';
import 'dart:convert';

import 'package:myapp/model/home_model.dart';

const APPBAR_SCROLL_OFFSET = 100; //最大滚动距离

class HomePage extends StatefulWidget{
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<HomePage>{
  final PageController _controller = PageController(
    initialPage: 0,
  );
  // 轮播图片地址
  List _imgUrls = [
    'https://dimg04.c-ctrip.com/images/zg0p15000000yk2nm8B2F.jpg',
    'https://dimg04.c-ctrip.com/images/zg0a15000000ypf1tBC70.jpg',
    'https://dimg04.c-ctrip.com/images/zg0e15000000yqzweE43E.jpg',
  ];

  // appbar的透明度
  double appBarAlpha = 0;
  
  // 服务端请求结果
  String resultString ;
  
  // 滚动触发
  _onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha < 0){
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
  
  // 获取首页数据
  loadData() async {
//    HomeDao.fetch().then((result) => {
//      setState(() {
//        resultString = json.encode(result);
//      })
//    }).catchError((e){
//      setState(() {
//        resultString = json.encode(e);
//      });
//    });
    HomeModel model = await HomeDao.fetch();
    print(json.encode(model.config));
    setState(() {
      resultString = json.encode(model.config);
    });
  }
  
  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NotificationListener( // 监听滚动事件的widget
                onNotification: (scrollNotification){
                  // 第0个元素的滚动才触发
                  if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    // 顶部滑动
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imgUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context,int index){
                          return Image.network(
                              _imgUrls[index],
                              fit: BoxFit.fill
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
                    ),
                    GridNav(gridNavModel: null,name:'12'),
                    // 下面
                    Container(
                      height: 800,
                      child: ListTile(title: Text('aaa'),),
                    )
                  ],
                ),
              )
          ),
          // appbar
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),// 背景色
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页')
                ),
              ),
            ),
          )
        ],
      )
    );
  }

}
