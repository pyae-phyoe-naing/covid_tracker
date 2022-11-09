import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/screen/country_screen/country_bloc.dart';
import 'package:flutter/material.dart';

import '../../model/country_ob.dart';
import '../../widget/select_country_widget.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final CountryBloc _countryBloc = CountryBloc();
  final TextEditingController _searchController = TextEditingController();
  List<CountryOb> countries = [];
  List<CountryOb> filterCountries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryBloc.getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (str) {
                if (str.isEmpty) {
                  filterCountries = [];
                } else {
                  filterCountries = countries.where((CountryOb co) {
                    return co.country!
                        .toLowerCase()
                        .contains(str.toLowerCase());
                  }).toList();
                }
                setState(() {});
              },
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Search City'),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<ResponseOb>(
                stream: _countryBloc.getCountryStream(),
                initialData: ResponseOb(msgState: MsgState.loading),
                builder:
                    (BuildContext context, AsyncSnapshot<ResponseOb> snapshot) {
                  ResponseOb responseOb = snapshot.data!;
                  if (responseOb.msgState == MsgState.data) {
                    countries = responseOb.data;
                    return selectCountryWidget(countries, filterCountries,_searchController.text);
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _countryBloc.dispose();
    super.dispose();
  }
}
