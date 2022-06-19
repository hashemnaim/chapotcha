import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomAppBarItem {
  String icon;
  String titel;
  bool hasNotification;

  CustomAppBarItem({this.icon, this.hasNotification = false , this.titel});
}

class CustomBottomAppBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;

  CustomBottomAppBar({this.onTabSelected, this.items}) ;

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int selectedIndex = 0;

  void _updateIndex(index) {
    widget.onTabSelected(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabIcon(
          index: index, item: widget.items[index], onPressed: _updateIndex);
    });
    items.insert(items.length >> 1, _buildMiddleSeparator());

    return BottomAppBar(
      child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
          ),
        height: 50.0,
        child: Row(
        //  mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _buildMiddleSeparator() {
    return Expanded(
      child: SizedBox(
        height: 30.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(
      {int index, CustomAppBarItem item, ValueChanged<int> onPressed}) {
        double sizeH = MediaQuery.of(context).size.height;
    return Expanded(
      child: SizedBox(
        height: sizeH*0.1,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child:  
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                SvgPicture.asset(
                  item.icon,
                  color: Provider.of<HomeProvieder>(context).indexN == 4 ? Color(0xff98B119)
                  : Provider.of<HomeProvieder>(context).indexN == index
                      ? Colors.blue[900]
                      : Color(0xff98B119),
                ),

                 Text(item.titel,style: TextStyle(fontSize: 8,
                 color: Provider.of<HomeProvieder>(context).indexN == 4 ? Color(0xff98B119)
                  : Provider.of<HomeProvieder>(context).indexN == index
                      ? Colors.blue[900]
                      : Color(0xff98B119),
                 ),),
              ],
            )
            
                  ),
          ),
        ),
      
    );
  }
}
