import 'package:covid_tracker/model/summary_ob.dart';
import 'package:flutter/material.dart';

Widget homeMainWidget(SummaryOb summaryOb) {
  var global = summaryOb.global!;
  return Column(
    children: [
      // Summary
      Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Total Confirmed
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Confirmed',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${global.totalConfirmed}",
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
                                text: "${global.newConfirmed}",
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
                    const Text('Total Deaths',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${global.totalDeaths}",
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
                                text: "${global.newDeaths}",
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
                    const Text('Total Recovered',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${global.totalRecovered}",
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
                                text: "${global.newRecovered}",
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
        ),
      ),
    ],
  );
}
