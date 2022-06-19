import 'package:capotcha/features/providers/home_provieder.dart';
import 'package:capotcha/models/profile_modal.dart';
import 'package:capotcha/value/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryItem extends StatefulWidget {
  final int i;
  HistoryItem(this.i);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<HistoryItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> data =
        Provider.of<HomeProvieder>(context).profilemodal.user.order;
    //double sizeH = MediaQuery.of(context).size.height;
    return ListView.builder(
        itemCount: data[widget.i].details.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            data[widget.i].details[index].productName,
                            style: Style.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            "كيلو  ${data[widget.i].details[index].quantity}",
                            style: Style.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        child: Text(
                          "${double.parse(data[widget.i].details[index].price) * double.parse(data[widget.i].details[index].quantity)} جنيه",
                          style: Style.cairo,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
