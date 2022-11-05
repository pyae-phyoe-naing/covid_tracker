import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/model/summary_ob.dart';
import 'package:covid_tracker/screen/home_screen/home_bloc.dart';
import 'package:covid_tracker/widget/home_main_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc.getCovidSummaryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.7),
      appBar: AppBar(
        title: const Text('Covid Tracker'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _homeBloc.getCovidSummaryStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot) {
          ResponseOb responseOb = snapshot.data!;
          if (responseOb.msgState == MsgState.data) {
            SummaryOb summaryOb = responseOb.data;
            return homeMainWidget(summaryOb);
          } else if (responseOb.msgState == MsgState.error) {
            if (responseOb.errState == ErrState.serverErr) {
              return const Center(
                child: Text('500\nServer Error'),
              );
            }else if(responseOb.errState == ErrState.notFoundErr){
              return const Center(
                child: Text('404\nPage Not Found'),
              );
            }else{
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
