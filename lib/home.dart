import 'package:flutter/material.dart';
import 'package:gallery/galleria.dart';
import 'package:plugin_demo/plugin_demo_view.dart';
import 'package:flutterame/mine.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TabItem { galleria, plugin, mine }

// https://api.flutter.dev/flutter/material/Icons-class.html
const TabItems = {
  TabItem.galleria: {
    'icon': Icons.extension,
    'title': '组件',
    'widget': Galleria()
  },
  TabItem.plugin: {
    'icon': Icons.power,
    'title': '插件',
    'widget': PluginDemoView()
  },
  TabItem.mine: {'icon': Icons.face, 'title': '我的', 'widget': Mine()}
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
    List<BottomNavigationBarItem> list = [];
    TabItems.forEach((TabItem key, Map value) {
      list.add(BottomNavigationBarItem(
          icon: Icon(value['icon']), label: value['title']));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
