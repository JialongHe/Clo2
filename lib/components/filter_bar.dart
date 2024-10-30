import 'package:clo2/components/filter_button.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  String mode = "day";
  int activeIndex = 0;

  List<Map<String, String>> getPast7Days() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) {
      DateTime day = today.subtract(Duration(days: index));
      return {
        'label': '${day.day} ${_getMonthName(day.month)}',
        'value': day.toIso8601String(),
      };
    }).toList();
  }

  List<Map<String, String>> getPast6Months() {
    DateTime today = DateTime.now();
    return List.generate(6, (index) {
      DateTime month = DateTime(today.year, today.month - index, 1);
      return {
        'label': '${_getMonthName(month.month)} ${month.year}',
        'value': month.toIso8601String(),
      };
    }).toList();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filterData =
        mode == 'day' ? getPast7Days() : getPast6Months();

    return Container(
        height: 32,
        width: double.infinity,
        padding: AppTheme.horizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/common/keyboard_arrow_down.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8), // TODO, Change to arrow icon in 2.0
            Text(
              mode == 'day' ? 'Day' : 'Month',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Color(0xFF072100),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 16 / 16),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: filterData.asMap().entries.map((entry) {
                    int index = entry.key;
                    String label = entry.value['label']!;
                    DateTime dateValue = DateTime.parse(entry.value['value']!);
                    // Check if the date is today
                    bool isToday =
                        DateTime.now().difference(dateValue).inDays == 0 &&
                            DateTime.now().day == dateValue.day;

                    // Modify label for today
                    String displayLabel =
                        isToday ? 'Today $label' : dateValue.day.toString();
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: FilterButton(
                        label: displayLabel,
                        isActive: activeIndex == index,
                        onTap: () {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ));
  }
}
