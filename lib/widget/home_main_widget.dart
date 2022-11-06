import 'package:covid_tracker/model/summary_ob.dart';
import 'package:covid_tracker/widget/countries_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget homeMainWidget(SummaryOb summaryOb) {
  var global = summaryOb.global!;
  var countries = summaryOb.countries!; 
  var numberFormat = NumberFormat(',###', 'en_US');
  return Column(
    children: [
      // Summary
      Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Update date : ${DateFormat("EEEE, MMMM dd, yyyy, hh : MM").format(
                  DateTime.parse(global.date!),
                )}',
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // Total Confirmed
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total\nConfirmed',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          numberFormat.format(global.totalConfirmed),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "New : ",
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                    text: numberFormat.format(global.newConfirmed),
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold))
                              ]),
                        )
                      ],
                    ),
                  ),
                  // Total Death
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total\nDeaths',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          numberFormat.format(global.totalDeaths) ,
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "New : ",
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                    text:numberFormat.format(global.newDeaths),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold))
                              ]),
                        )
                      ],
                    ),
                  ),
                  // Total Recover
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total\nRecovered',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                         numberFormat.format(global.totalRecovered),
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "New : ",
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                    text: numberFormat.format(global.newRecovered) ,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold))
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Countries
     const  Divider(color: Colors.deepPurpleAccent),
      const SizedBox(height: 5,),
      Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:const[
            Icon(Icons.home_work_outlined,color: Colors.deepPurple,),
            SizedBox(width:5,),
            Text(
            ' နိူင်ငံအားလုံး',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),]
        ),
      ),
       const SizedBox(height: 5,),
      const Divider(color: Colors.grey,),
      Expanded(
        child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (BuildContext context, index) {
              return CountriesWidget(country: countries[index]);
            }),
      ),
    ],
  );
}
