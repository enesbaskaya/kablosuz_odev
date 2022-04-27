import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:kablosuz_odev/screens/home/widgets/wifi_info_row.dart';
import 'package:lottie/lottie.dart';
import 'package:network_info_plus/network_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final info = NetworkInfo();
  String? wifiName;
  String? wifiBSSID;
  String? wifiIP;
  String? wifiIPv6;
  String? wifiSubmask;
  String? wifiBroadcast;
  String? wifiGateway;
  ConnectivityResult? result;

  @override
  void initState() {
    loadWifiInfo();

    super.initState();
  }

  void loadWifiInfo() async {
    wifiName = await info.getWifiName();
    wifiBSSID = await info.getWifiBSSID();
    wifiIP = await info.getWifiIP();
    wifiIPv6 = await info.getWifiIPv6();
    wifiSubmask = await info.getWifiSubmask();
    wifiBroadcast = await info.getWifiBroadcast();
    wifiGateway = await info.getWifiGatewayIP();
    if (mounted) {
      setState(() {});
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          this.result = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wifi Info'),
      ),
      body: result == ConnectivityResult.wifi
          ? Column(
              children: [
                WifiInfoRow(title: 'Wifi Name', value: wifiName),
                WifiInfoRow(title: 'Wifi BSSID', value: wifiBSSID),
                WifiInfoRow(title: 'Wifi IP', value: wifiIP),
                WifiInfoRow(title: 'Wifi IPv6', value: wifiIPv6),
                WifiInfoRow(title: 'Wifi Submask', value: wifiSubmask),
                WifiInfoRow(title: 'Wifi Broadcast', value: wifiBroadcast),
                WifiInfoRow(title: 'Wifi Gateway', value: wifiGateway),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/warning.json'),
                  const Text('Lütfen bir Wifi bağlantısı kurun.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
    );
  }
}
