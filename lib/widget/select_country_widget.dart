import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/country_ob.dart';

Widget selectCountryWidget(List<CountryOb> countries,List<CountryOb> filterCountries,search) {
  return ListView.builder(
      itemCount:search.isNotEmpty ? filterCountries.length : countries.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).pop(search.isNotEmpty ?filterCountries[index].slug : countries[index].slug);
              },
          leading: const Icon(
            Icons.flag_circle,
            color: Colors.indigo,
          ),
          title: Text(search.isNotEmpty ? filterCountries[index].country.toString():countries[index].country.toString()),
          subtitle: Text(search.isNotEmpty ? filterCountries[index].iSO2.toString() :countries[index].iSO2.toString()),
          trailing: const Icon((Icons.chevron_right)),
        ));
      });
}
