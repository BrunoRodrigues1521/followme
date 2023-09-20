import 'package:collection/src/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/controllers/user_controller.dart';
import 'package:followme/helpers/common/helpers.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/providers/api_provider.dart';

class RouteInfoModalSection1 extends StatelessWidget {
  const RouteInfoModalSection1(this.routes, {Key? key}) : super(key: key);
  final routes;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                routes.name,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                ),
                onPressed: () async {
                  SessionModel session = await SessionController.readUserInfo();
                  try{
                    var result = await UserController.addFavourites(session.email, routes.id, session.token);
                  }catch(err){}

                },
                child:
                Text(
                  "Save this",
                  style: TextStyle(fontFamily: 'Pacifico'),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/profile_pic_placeholder.png"),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(routes.email),
              Spacer(),
              Image.asset(
                "assets/icons/distance_icon.png",
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text(routes.distance.toString()+"km")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(height: 20),
              RatingBar(
                minRating: 0,
                initialRating: double.parse(routes.rating.toString()),
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Image.asset('assets/icons/favourite_icon_fill.png'),
                  half: Image.asset('assets/favourite_icon_fill.png'),
                  empty: Image.asset('assets/icons/favourite_icon.png'),
                ),
                onRatingUpdate: (rating) async {
                  print(rating);
                  SessionModel session = await SessionController.readUserInfo();
                  var result =  await APIProvider.addRatings(routes.id,rating,session.token);
                },
              ),
              Spacer(),
              Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Color(0xffED7C30).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.all(5),
                child: Text(CommonHelpers.convertDifficulty(routes!.difficulty),
                  style: TextStyle(
                      color: Color(0xffED7C30),
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: routes.tags.length,
              itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffed7c30),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {},
                    child: Text(
                      routes.tags[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )

                ),
              );
            },

            ),
          )
        ],
      ),
    );
  }
}
