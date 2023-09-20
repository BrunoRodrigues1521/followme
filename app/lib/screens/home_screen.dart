import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:followme/utilities/widgets/map_widget.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  List<RouteModel> lastRoutes = [];
  List<RouteModel> nearestRoutes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearest Routes',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Flexible(
                  child: FutureBuilder<List>(
                    future: _getNearestRoutes(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, int position) {
                                final item = snapshot.data![position];
                                //get your item data here ...
                                return SizedBox(
                                  width: 300,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MapWidget(routeId: item.name),
                                        ),
                                      );
                                    },
                                    child: Card(
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        margin:
                                            const EdgeInsets.only(right: 30.0),
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        color: FollowMeColors.lightAccentColor,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 60,
                                              child: Image.network(
                                              item.images[0],
                                              width: double.infinity,
                                              fit: BoxFit.fitWidth,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/images/routeDefaultImage.JPG",
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              ),),
                                            Expanded(
                                              flex: 40,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                color: FollowMeColors
                                                    .darkAccentColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children:  [
                                                        //TODO: replace with User name
                                                        Text(item.email,
                                                            style:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                        //TODO: replace with time route was added
                                                        Text("1 hour ago",
                                                            style:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Routes',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Flexible(
                    child: FutureBuilder<List>(
                      future: _getRoutes(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, int position) {
                                  final item = snapshot.data![position];
                                  return Card(
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: FollowMeColors.lightAccentColor,
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MapWidget(routeId: item.name),
                                          ),
                                        );
                                      },
                                      title: Text(item.name),
                                      trailing: const Icon(Icons.chevron_right),
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<List<RouteModel>> _getRoutes() async {
    SessionModel session = await SessionController.readUserInfo();
    var result = await APIProvider.getRoutes(session.email, session.token);
    if (result == "expired") {
      SessionController.deleteSession();
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (Route route) => false,
      );
    }
    return result;
  }

  Future<List<RouteModel>> _getNearestRoutes() async {
    SessionModel session = await SessionController.readUserInfo();
    var result = await APIProvider.getNearestRoutes("Porto", 30.044281, 31.340002, session.token);
    if (result == "expired") {
      SessionController.deleteSession();
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (Route route) => false,
      );

    }
    return result;
  }

}
