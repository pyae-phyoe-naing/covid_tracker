import 'dart:async';
import 'dart:convert';

import 'package:covid_tracker/model/response_ob.dart';
import 'package:covid_tracker/model/summary_ob.dart';
import 'package:covid_tracker/util/app_const.dart';
import 'package:http/http.dart' as http;

class HomeBloc {
  final StreamController<ResponseOb> _controller =
      StreamController<ResponseOb>();

  Stream<ResponseOb> getCovidSummaryStream() => _controller.stream;

  getCovidSummaryData() async {

    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(responseOb);

    var response = await http.get(Uri.parse(summaryUrl));
    if (response.statusCode == 200) {
      Map<String,dynamic> data = json.decode(response.body);
      SummaryOb summaryOb = SummaryOb.fromJson(data);

      responseOb.msgState = MsgState.data;
      responseOb.data = summaryOb;
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
