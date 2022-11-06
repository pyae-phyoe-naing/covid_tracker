import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/country_ob.dart';

Widget SelectCountryWidget(List<CountryOb> countries) {
  return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).pop(countries[index].slug);
              },
          leading: const Icon(
            Icons.flag_circle,
            color: Colors.indigo,
          ),
          title: Text(countries[index].country.toString()),
          subtitle: Text(countries[index].iSO2.toString()),
          trailing: const Icon((Icons.chevron_right)),
        ));
      });
}
