// // ignore_for_file: must_be_immutable

// import 'package:capotcha/value/styles.dart';
// import 'package:flutter/material.dart';

// class TileTalep extends StatelessWidget {
//   int number;
//   String productName;
//   num quantity;
//   num price;
//   String status;
//   TileTalep(
//       this.number, this.productName, this.quantity, this.price, this.status);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ExpansionTile(
//           backgroundColor: Colors.grey[300],
//           title: Text(
//             "طلبك رقم $number",
//             style: Style.cairog,
//           ),
//           children: <Widget>[
//             Divider(),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "$productName",
//                             style: Style.cairo,
//                           ),
//                           Text(
//                             "كيلو $quantity",
//                             style: Style.cairo,
//                           ),
//                           Text(
//                             "$price جنيه",
//                             style: Style.cairo,
//                           )
//                         ],
//                       ),
//                     ),
//                     Divider(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "حالة الطلب",
//                             style: Style.cairog,
//                           ),
//                           Text(
//                             "$status",
//                             style: Style.cairo,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
