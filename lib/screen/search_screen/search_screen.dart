import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/model/search_country_ob.dart';
import 'package:covid_tracker/screen/country_screen/country_screen.dart';
import 'package:covid_tracker/screen/search_screen/search_bloc.dart';
import 'package:covid_tracker/widget/search_country_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _searchBloc = SearchBloc();
  final TextEditingController _countryController = TextEditingController();
  String dateRange = 'Select Date Range';
  String? fromDate;
  String? toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page',),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Select City
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => const CountryScreen(),
                  ),
                )
                    .then((value) {
                  if (value != null) {
                    _countryController.text = value;
                  }
                });
              },
              child: TextFormField(
                controller: _countryController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Select City',
                  labelStyle: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Date Range Picker
            OutlinedButton(
              style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.deepPurpleAccent))),
              onPressed: () {
                showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now())
                    .then((date) {
                  if (date != null) {
                    var firstDate = date.start.toString().split(' ')[0];
                    var lastDate = date.end.toString().split(' ')[0];
                    fromDate = date.start.toString();
                    toDate = date.end.toString();
                    dateRange = "$firstDate - $lastDate";
                    setState(() {});
                  }
                });
              },
              child: Text(
                dateRange,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 15),
              ),
            ),
            // Search Button
            ElevatedButton(
              onPressed: () {
                if (_countryController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Select Country',style: TextStyle(color: Colors.white),),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                if (fromDate == null || toDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Select From Date and To Date',style: TextStyle(color: Colors.white),),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                 _searchBloc.getSearchData(_countryController.text, fromDate!, toDate!);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
              child: const Text('Search'),
            ),
            const SizedBox(height: 15,),
            const Divider(),
            // StreamBuilder For Search Country Data
            Expanded(
                child: StreamBuilder<ResponseOb>(
                  stream: _searchBloc.getSearchSteam(),
                  builder:
                      (BuildContext context,
                      AsyncSnapshot<ResponseOb> snapshot) {
                    if (snapshot.hasData) {
                      ResponseOb responseOb = snapshot.data!;
                      if (responseOb.msgState == MsgState.data) {
                        List<SearchCountryOb> countries = responseOb.data;
                        return searchCountryDataWidget(countries);
                      } else if (responseOb.msgState == MsgState.error) {
                        if (responseOb.errState == ErrState.serverErr) {
                          return const Center(
                            child: Text('500\nServer Error'),
                          );
                        } else
                        if (responseOb.errState == ErrState.notFoundErr) {
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
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search, size: 40, color: Colors.indigo,),
                          Text('Search Data with Country and State',
                            style: TextStyle(color: Colors.indigo),)
                        ],
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
