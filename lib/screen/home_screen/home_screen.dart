import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/model/summary_ob.dart';
import 'package:covid_tracker/screen/search_screen/search_screen.dart';
import 'package:covid_tracker/widget/home_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc.getCovidSummaryData();
    _homeBloc.getCovidSummaryStream().listen((ResponseOb responseOb) {
      if(responseOb.msgState == MsgState.data){
        refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70.withOpacity(.7),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Covid Tracker'),
        // centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: () =>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchScreen())),
              icon: const Icon(Icons.search, size: 30,)),
          //IconButton(onPressed: ()=> _homeBloc.getCovidSummaryData(), icon:const Icon(Icons.refresh)),
        ],
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _homeBloc.getCovidSummaryStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot) {
          ResponseOb responseOb = snapshot.data!;
          if (responseOb.msgState == MsgState.data) {
            SummaryOb summaryOb = responseOb.data;
            return homeMainWidget(summaryOb,_homeBloc,refreshController);
          } else if (responseOb.msgState == MsgState.error) {
            if (responseOb.errState == ErrState.serverErr) {
              return const Center(
                child: Text('500\nServer Error'),
              );
            } else if (responseOb.errState == ErrState.notFoundErr) {
              return const Center(
                child: Text('404\nPage Not Found'),
              );
            } else {
              return const Center(
                child: Text('Unknown Error'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _homeBloc.dispose();
    super.dispose();
  }
}
