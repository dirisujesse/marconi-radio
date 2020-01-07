import 'package:flutter/material.dart';
import 'package:marconi_radio/components/typography/app_txt.dart';
import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/styles/colors.dart';

class AppSection extends StatelessWidget {
  final List<AppCategory> data;
  final String name;

  AppSection({@required this.data, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          margin: EdgeInsets.only(left: 10),
          child: BodyText(
            name,
            color: appWhite,
            alignment: TextAlign.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: appBlack,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // childAspectRatio: 3 / 4,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, idx) {
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                                child: Hero(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appBlack,
                                  image: DecorationImage(
                                    image: NetworkImage(data[idx].image),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              tag: data[idx].assetName,
                            )),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: BodyText(
                                data[idx].name,
                                fontWeight: FontWeight.bold,
                                color: appBlack,
                              ),
                              subtitle: Text(
                                "${data[idx].count} stations",
                              ),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.of(context).pushNamed(
                          '/list/${data[idx].assetName}',
                          arguments: data[idx],
                        ),
                      );
                    },
                    childCount: data.length,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
