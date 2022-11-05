import 'package:covid_tracker/screen/home_screen/home_bloc.dart';
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
      appBar: AppBar(title:const Text('Covid Tracker'),centerTitle: true,backgroundColor: Colors.deepPurple,),
      body: Column(
        children: [

        ],
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
