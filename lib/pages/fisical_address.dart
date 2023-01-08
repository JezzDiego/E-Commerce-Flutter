import 'package:araplantas_mobile/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FisicalAddress extends StatefulWidget {
  const FisicalAddress({Key? key}) : super(key: key);

  @override
  State<FisicalAddress> createState() => _FisicalAddressState();
}

class _FisicalAddressState extends State<FisicalAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          title: Text(
            'Endereço Físico',
            style: GoogleFonts.inter(),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nosso endereço físico",
                  style: GoogleFonts.inter(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.76,
              child: const MapPage(
                  latLong: LatLng(-9.734482837823514, -36.6556828018377)),
            )
          ],
        ));
  }
}
