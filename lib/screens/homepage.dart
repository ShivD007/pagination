import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paginatio/extra/apiclass.dart';
import 'package:paginatio/extra/url.dart';
import 'package:paginatio/model/profileModel.dart';
import 'package:paginatio/widget/profileTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  ProfileList profile;

  ScrollController _controller = ScrollController();
  bool isLoading = false;
  var _DataList;
  List<Profile> profiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getProfiledata(page);
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        getProfiledata(page);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Users List"),
        ),
        backgroundColor: Colors.blueGrey,
        body: profiles.length != null
            ? ListView.builder(
                controller: _controller,
                shrinkWrap: true,
                itemCount: profiles.length + 1,
                itemBuilder: (context, index) => (index == profiles.length)
                    ? Center(
                        child: Opacity(
                            opacity: isLoading ? 1.0 : 00,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Loading Users...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    : ProfileTile(profiles[index]))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void getProfiledata(int page) {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    var data = {"url": Url.url + "$page"};
    ApiClass.getApiCall(data, (onSucess) {
      var rootJson = jsonDecode(onSucess["response"]);
      profile = ProfileList.fromJson(rootJson);
      print("profile =======> ${profile.data.length}");
      var templist = profile.data;
      profiles.addAll(templist);
      this.page++;
      setState(() {
        isLoading = false;
      });
    }, (onError) {
      setState(() {
        isLoading = false;
      });
      print(onError["message"]);
    });
  }
}
