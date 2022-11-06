import 'dart:async';
import 'dart:convert';

import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/model/search_country_ob.dart';
import 'package:covid_tracker/util/app_const.dart';
import 'package:http/http.dart' as http;

class SearchBloc {
  final StreamController<ResponseOb> _controller =
      StreamController<ResponseOb>();

  Stream<ResponseOb> getSearchSteam() => _controller.stream;

  getSearchData(String countrySlug, String firstDate, String lastDate) async {
    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(responseOb);

    var response = await http.get(Uri.parse(
        "$searchCountryUrl$countrySlug?from=$firstDate&to=$lastDate"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<SearchCountryOb> searchCountry = [];
      data.forEach((countryData) {
        searchCountry.add(SearchCountryOb.fromJson(countryData));
      });

      responseOb.msgState = MsgState.data;
      responseOb.data = searchCountry;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 500) {
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.serverErr;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 404) {
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(responseOb);
    } else {
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.unknownErr;
      _controller.sink.add(responseOb);
    }
  }

  dispose() {
    _controller.close();
  }
}
