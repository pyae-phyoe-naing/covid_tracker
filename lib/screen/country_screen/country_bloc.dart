import 'dart:async';
import 'dart:convert';

import 'package:covid_tracker/model/country_ob.dart';
import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/util/app_const.dart';
import 'package:http/http.dart' as http;

class CountryBloc {
  final StreamController<ResponseOb> _controller =
  StreamController<ResponseOb>();

  Stream<ResponseOb> getCountryStream() => _controller.stream;

  getCountryData() async {

    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(responseOb);

    var response = await http.get(Uri.parse(countriesUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<CountryOb> countryList = [];
       data.forEach((element) {
        countryList.add(CountryOb.fromJson(element));
      });

      responseOb.msgState = MsgState.data;
      responseOb.data = countryList;
      _controller.sink.add(responseOb);

    }else if(response.statusCode == 500){
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.serverErr;
      _controller.sink.add(responseOb);
    }else if(response.statusCode == 404){
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(responseOb);
    }else{
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.unknownErr;
      _controller.sink.add(responseOb);
    }
  }

  dispose() {
    _controller.close();
  }
}
