import 'package:flutter/material.dart';
import '../../../environment/colors.dart';

enum Status { lengkap, kurang, kosong }

class SiswaCard extends StatelessWidget {
  final Status status;
  final String tanggal;
  const SiswaCard(
      {super.key, this.status = Status.kosong, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    late String statusText;
    late Color statusColor;

    switch (status) {
      case Status.lengkap:
        statusText = "Lengkap";
        statusColor = greenColor;
        break;
      case Status.kurang:
        statusText = "Kurang";
        statusColor = orangeColor;
        break;
      case Status.kosong:
        statusText = "Kosong";
        statusColor = redColor;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
