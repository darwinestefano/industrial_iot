import 'package:flutter/material.dart';

import 'package:industrial_iot_app/widgets/custom_app_bar.dart';
import 'package:industrial_iot_app/widgets/humidity_rt_setup/hum_envRT_controller.dart';
import 'package:industrial_iot_app/widgets/humidity_rt_setup/hum_envRT_logs_grid.dart';
import 'package:industrial_iot_app/widgets/humidity_rt_setup/hum_envRT_stats_grid.dart';
import 'package:industrial_iot_app/widgets/humidity_rt_setup/humidity_chart/hum_envRT_chart.dart';

class HumidityDashboard extends StatefulWidget {
  @override
  _HumidityDashboardState createState() => _HumidityDashboardState();
}

class _HumidityDashboardState extends State<HumidityDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: HumidityController(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: HumEnvRTStatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: HumEnvRTLogsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: HumidityRTChart(),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'HUMIDITY DASHBOARD',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
