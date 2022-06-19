/*
*  shadows.dart
*  DhabayehAlEmarat
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Shadows {
  static  BoxShadow primaryShadow = BoxShadow(
    color:Colors.grey.withOpacity(0.1),
    offset: Offset(1, 4),
    blurRadius: 5,
                   // spreadRadius: 1,

  );
  static const BoxShadow secondaryShadow = BoxShadow(
                color: Color.fromARGB(41, 163, 163, 163),
                spreadRadius: 8,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              );
            
}    
          