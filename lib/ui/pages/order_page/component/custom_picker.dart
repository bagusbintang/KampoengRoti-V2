import 'dart:math';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({
    DateTime? currentTime,
    DateTime? minTime,
    DateTime? maxTime,
    LocaleType? locale,
  }) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    int? delivStartTime = UserSingleton().outlet.delivStart;
    int? delivEndTime = UserSingleton().outlet.delivEnd;
    int? pickUpStartTime = UserSingleton().outlet.pickUpStart;
    int? pickUpEndTime = UserSingleton().outlet.pickUpEnd;
    bool isDeliv = UserSingleton().isDeliveryOption;
    int startTime = isDeliv ? delivStartTime! : pickUpStartTime!;
    int endTime = isDeliv ? delivEndTime! : pickUpEndTime!;
    int jamDefault = currentTime.hour + 2;
    if (jamDefault >= startTime) {
      startTime = jamDefault;
    }
    if (index < 0) {
      if (index >= startTime && index <= endTime) {
        return this.digits(index, 2);
      }
    } else {
      if (index >= startTime && index <= endTime) {
        return this.digits(index, 2);
      } else {
        return null;
      }
    }

    // if (index >= 0 && index < 24) {
    //   return this.digits(index, 2);
    // } else {
    //   return null;
    // }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
