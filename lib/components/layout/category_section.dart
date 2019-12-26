import 'package:flutter/material.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
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
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
          margin: EdgeInsets.only(left: 20),
          child: BodyText(name, color: appWhite, alignment: TextAlign.center,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: appBlack
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, idx) {
                      return GestureDetector(
                        child: Hero(
                          child: Container(
                            decoration: BoxDecoration(
                              color: data[idx].color,
                              image: DecorationImage(
                                image: NetworkImage(data[idx].image),
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                  appBlack.withOpacity(0.7),
                                  BlendMode.darken,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: HeaderText(
                                data[idx].name,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: appWhite,
                                alignment: TextAlign.center,
                              ),
                            ),
                          ),
                          tag: data[idx].assetName,
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
