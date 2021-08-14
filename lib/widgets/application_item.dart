import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/houseapplication.dart' as ord;

class ApplicationItem extends StatefulWidget {
  final ord.HouseApplication applica;

  ApplicationItem(this.applica);

  @override
  _ApplicationItemState createState() => _ApplicationItemState();
}

class _ApplicationItemState extends State<ApplicationItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
      // _expanded ? min(widget.applica.houses.length * 100.0 + 160, 200) : 95,
          _expanded ? min(widget.applica.houses.length * 200.0 + 160, 255) : 95,
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
            
            
           
            //  AnimatedContainer(
            //   duration: Duration(milliseconds: 300),
            //   padding: EdgeInsets.symmetric(horizontal: 95, vertical: 4),
            //   height: _expanded ? min(widget.applica.houses.length * 20.0 + 10, 100) : 0,
            //   child: ListView(
            //     children: widget.applica.houses
            //         .map(
            //           (prod) => Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: <Widget>[
            //                   Text(
            //                     prod.at,
            //                     style: TextStyle(
            //                       fontSize: 18,
                                  
            //                       color: Colors.blueAccent,
            //                     ),
            //                   ),
                              
                              
                              
            //                 ],
                            
            //               ),
                          
            //         )
            //         .toList(),
                    
                    
            //   ),
            // ),
    
          ],
        ),
      ),
    );
  }
}
