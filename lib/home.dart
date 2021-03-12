import 'package:flutter/material.dart';
import 'package:gallery/galleria.dart';
import 'package:flutterame/mine.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TabItem { galleria, mine }

const TabItems = {
  TabItem.galleria: {'icon': Icons.school, 'title': '画廊', 'widget': Galleria()},
  TabItem.mine: {'icon': Icons.more_horiz, 'title': '我的', 'widget': Mine()}
};

TabItem _getTypeByIndex(int index) {
  var type = TabItem.galleria;
  TabItems.forEach((TabItem key, Map value) {
    if (key.index == index) {
      type = key;
    }
  });
  return type;
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectIndex = 0;
  TabItem _currentTab = TabItem.galleria;
  void _onItemTapped(int index) {
    setState(() {
      var tab = _getTypeByIndex(index);
      _selectIndex = index;
      _currentTab = tab;
      print('_selectIndex($_selectIndex)');
      print('_currentTab($_currentTab)');
    });
  }

  List<BottomNavigationBarItem> _createTabs() {
    List<BottomNavigationBarItem> list = new List<BottomNavigationBarItem>();
    TabItems.forEach((TabItem key, Map value) {
      list.add(BottomNavigationBarItem(
          icon: Icon(value['icon']), label: value['title']));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
      ),
      body: TabItems[_currentTab]!['widget'] as Widget?,
      bottomNavigationBar: BottomNavigationBar(
        items: _createTabs(),
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
