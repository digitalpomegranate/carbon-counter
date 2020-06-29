import 'dart:async';
import 'dart:math';

import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/themes.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/ui/comply/compy_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ComplyChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComplyChartState();
}

class ComplyChartState extends State<ComplyChart> {
  final Color barBackgroundColor = AppColors.bermuda;
  final Duration animDuration = const Duration(milliseconds: animationDuration);

  int touchedIndex;

  bool isPlaying = false;
  AppLocalizations locals;

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: AppColors.lima,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(padding * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    locals.carbonEmission,
                    style:
                        Theme.of(context).primaryTextTheme.headline3.copyWith(
                              color: AppColors.white,
                              fontSize: carbonEmissionFontSzie,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppThemes.secondaryFontFamily,
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: padding),
                    child: Text(
                      locals.carbonEmissionOffsetOptions,
                      style:
                          Theme.of(context).primaryTextTheme.headline3.copyWith(
                                color: AppColors.white,
                                fontSize: offsetOptionsFontSize,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppThemes.secondaryFontFamily,
                              ),
                    ),
                  ),
                  const SizedBox(
                    height: spacingBeforeBarChart,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: padding * 2),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spacingAfterBarChart,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(padding * 2),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.eden,
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = groupDataWidth,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? AppColors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppColors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = locals.monday;
                  break;
                case 1:
                  weekDay = locals.tuesday;
                  break;
                case 2:
                  weekDay = locals.wednesday;
                  break;
                case 3:
                  weekDay = locals.thursday;
                  break;
                case 4:
                  weekDay = locals.friday;
                  break;
                case 5:
                  weekDay = locals.saturday;
                  break;
                case 6:
                  weekDay = locals.sunday;
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: AppColors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: randomDataFontSize),
          margin: randomDataMargin,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: randomDataFontSize,
          ),
          margin: randomDataMargin,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: AppColors.challengeColors[Random().nextInt(
                AppColors.challengeColors.length,
              )],
            );
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 300));
    if (isPlaying) {
      refreshState();
    }
  }
}
