import 'package:flutter/material.dart';

void main() => runApp(new TabLayoutDemo());

class TabLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          body: TabBarView(
            children: [
              new Container(
                color: Colors.yellow,
              ),
              new Container(color: Colors.orange,),
              new Container(
                color: Colors.lightGreen,
              ),
              new Container(
                color: Colors.red,
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.rss_feed),
              ),
              Tab(
                icon: new Icon(Icons.perm_identity),
              ),
              Tab(icon: new Icon(Icons.settings),)
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
