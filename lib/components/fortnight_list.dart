import 'package:flutter/material.dart';

class FortnightList extends StatelessWidget {
  final iconUrl;
  final date;
  final temp;
  const FortnightList({super.key, this.iconUrl, this.temp, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(2,0,2,5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(iconUrl,height: 80,),
          Column(
            children: [
              Text('Date: ${date}',style:
                TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              Text('Temperature: ${temp.toString()}°C',style:
                TextStyle(
                  fontSize: 15,
                ),),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        )
      ),
    );
  }
}
