import 'package:flutter/material.dart';

import 'package:industrial_iot_app/widgets/custom_app_bar.dart';
import 'package:industrial_iot_app/widgets/dust_rt_setup/dust_chart/dust_envRT_chart.dart';
import 'package:industrial_iot_app/widgets/dust_rt_setup/dust_envRT_controller.dart';
import 'package:industrial_iot_app/widgets/dust_rt_setup/dust_envRT_logs_grid.dart';
import 'package:industrial_iot_app/widgets/dust_rt_setup/dust_envRT_stats_grid.dart';

class DustDashboard extends StatefulWidget {
  @override
  _DustDashboardState createState() => _DustDashboardState();
}

class _DustDashboardState extends State<DustDashboard> {
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
              child: DustController(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: DustEnvRTStatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: DustEnvRTLogsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: DustRTChart(),
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
          'DUST DASHBOARD',
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
