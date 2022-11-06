import 'package:covid_tracker/model/summary_ob.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountriesWidget extends StatelessWidget {
  Countries country;
  var numberFormat = NumberFormat(',###', 'en_US');
  CountriesWidget({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: '${country.country} . ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: numberFormat.format(country.newConfirmed),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.amber),
                    ),
                    const TextSpan(
                      text: '  New Cases',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  ]),

            ),
            const Divider(
              color: Colors.black38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Total Confirmed
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        numberFormat.format(country.totalConfirmed),
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Confirmed',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  // Total Death
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        numberFormat.format(country.totalDeaths),
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Deaths',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                  // Total Recover
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       numberFormat.format(country.totalRecovered),
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Recovered',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black38,
            ),
            Text(DateFormat('EEEE, MMMM dd, yyyy').format(DateTime.parse(country.date!),),style: TextStyle(color: Colors.white60),)
          ],
        ),
      ),
    );
  }
}
