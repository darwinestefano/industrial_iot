import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/config/palette.dart';

import 'package:industrial_iot_app/config/styles.dart';

import 'package:industrial_iot_app/widgets/custom_app_bar.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_month_logs_grid.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_month_stats_grid.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_today_logs_grid.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_today_stats_grid.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_week_logs_grid.dart';
import 'package:industrial_iot_app/widgets/hum_ds_setup/hum_week_stats_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_month_logs_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_month_stats_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_today_logs_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_today_stats_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_week_logs_grid.dart';
import 'package:industrial_iot_app/widgets/temp_ds_setup/temp_week_stats_grid.dart';

class TempEnvStatsScreen extends StatefulWidget {
  @override
  _TempEnvStatsScreenState createState() => _TempEnvStatsScreenState();
}

int tabIndex = 0;
int tabPeriod = 0;

class _TempEnvStatsScreenState extends State<TempEnvStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(),
      body: _selectView(tabIndex, tabPeriod),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.appBar,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Environmental Statistics',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 3,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.grey[300],
            ),
            labelStyle: tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black26,
            tabs: <Widget>[
              Text(
                'Temperature',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'Humidity',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'Dust',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
            onTap: (index) {
              if (index == 0)
                setState(() {
                  tabIndex = 0;
                });
              else if (index == 1)
                setState(() {
                  tabIndex = 1;
                });
              else
                setState(() {
                  tabIndex = 2;
                });
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: tabTextStyle,
            labelColor: Palette.primaryColor,
            unselectedLabelColor: Colors.black26,
            tabs: <Widget>[
              Text('Today'),
              Text('This week'),
              Text('This month'),
            ],
            onTap: (index) {
              if (index == 0)
                setState(() {
                  tabPeriod = 0;
                });
              else if (index == 1)
                setState(() {
                  tabPeriod = 1;
                });
              else
                setState(() {
                  tabPeriod = 2;
                });
            },
          ),
        ),
      ),
    );
  }

  CustomScrollView _selectView(int index, int period) {
    if (index == 0) {
      if (period == 0) {
        print(period);
        return _buildViews(TemperaureTodayStats(), TempTodayLogs());
      } else if (period == 1) {
        print(period);
        return _buildViews(TemperaureweekStats(), TempWeekGridLogs());
      } else {
        print(period);
        return _buildViews(TemperaureMonthStats(), TempMonthGridLogs());
      }
    } else if (index == 1) {
      if (period == 0)
        return _buildViews(HumidityTodayStats(), HumTodayLogs());
      else if (period == 1)
        return _buildViews(HumidityweekStats(), HumWeekGridLogs());
      else
        return _buildViews(HumidityMonthStats(), HumMonthGridLogs());
    } else {
      if (period == 0)
        return _buildViews(TemperaureTodayStats(), HumMonthGridLogs());
      else if (period == 1)
        return _buildViews(TemperaureTodayStats(), HumMonthGridLogs());
      else
        return _buildViews(TemperaureTodayStats(), HumMonthGridLogs());
    }
  }

  CustomScrollView _buildViews(dynamic stats, dynamic logs) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        _buildHeader(),
        _buildRegionTabBar(),
        _buildStatsTabBar(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          sliver: SliverToBoxAdapter(
            child: stats,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 20.0),
          sliver: SliverToBoxAdapter(
            child: logs,
          ),
        ),
      ],
    );
  }
}
