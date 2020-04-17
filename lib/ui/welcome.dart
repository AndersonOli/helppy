import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final _width = MediaQuery.of(context).size.width;
      final _height = MediaQuery.of(context).size.height;
      return Scaffold(
          body: CarouselSlider(
              options: CarouselOptions(
                  height: _height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  initialPage: 0,
                  enableInfiniteScroll: false,
              ),
              items: <Widget>[
                  Container(
                      width: _width,
                      height: _height,
                      child: Column(
                          children: <Widget>[

                          ],
                      ),
                  ),
                  Container(
                      width: _width,
                      color: Colors.red,
                  ),
                  Container(
                      width: _width,
                      color: Colors.green,
                  ),
              ],
          ),
      );
  }
}
