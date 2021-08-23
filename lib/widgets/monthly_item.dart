import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_count_down/date_count_down.dart';
import '../providers/houseapplication.dart' as ord;

class MonthlyItem extends StatefulWidget {
  final ord.HouseApplication applica;

  MonthlyItem(this.applica);

  @override
  _MonthlyItemState createState() => _MonthlyItemState();
}

class _MonthlyItemState extends State<MonthlyItem> {
  var _expanded = false;
  
  String countTime = "Loading...";
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
      // _expanded ? min(widget.applica.houses.length * 100.0 + 160, 200) : 95,
          _expanded ? min(widget.applica.houses.length * 220.0 + 160, 275) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.applica.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.applica.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
              
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                        
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.houseno,
                                
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                prod.status,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.co,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                 
                                ),
                              ),
                              
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
             AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
             AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.jobTtitle,
                                style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
             AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.company,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
            
            
            
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.applica.houses
                    .map(
                      (prod) => Row(
                        
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                // prod.at1,
                                CountDown().timeLeft(DateTime.parse(prod.at1), "Rent Completed, allowed to sign a contract certifying that the house is yours"),
                                
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  
                                  color: Colors.green,
                                ),
                              ),
                              
                              
                            ],
                            
                          ),
                          
                    )
                    .toList(),
                    
                    
              ),
            ),
          ],
        ),
      ),
    );
  }
}
