import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Graphics;
import Toybox.Math;
import Toybox.Application;

class BreezeSystemFieldUtils {
  // 获取当前小时12小时制
  function getSystemHour12(is24Hour as Boolean) as Lang.String {
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    if (is24Hour) {
      return hours.format("%02d");
    } else {
      if (hours > 12) {
        hours = hours - 12;
      }
      return hours.format("%02d");
    }
  }

  // 获取当前分钟
  function getSystemMinute() as Lang.String {
    var clockTime = System.getClockTime();
    return clockTime.min.format("%02d");
  }

  // 获取当前秒
  function getSystemSecond() as Lang.String {
    var clockTime = System.getClockTime();
    return clockTime.sec.format("%02d");
  }

  // 获取系统时间
  function getSystemTime() as Lang.String {
    var timeFormat = "$1$:$2$:$3$";
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;

    // 根据系统设置判断是12小时制还是24小时制
    if (!System.getDeviceSettings().is24Hour) {
      // 12小时制
      if (hours > 12) {
        hours = hours - 12;
      }
    } else {
      // 24小时制
      hours = hours.format("%02d");
    }

    return Lang.format(timeFormat, [
      hours,
      clockTime.min.format("%02d"),
      clockTime.sec.format("%02d"),
    ]);
  }

  // 获取当前星期
  function getSystemDayOfWeek() as Lang.String {
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    return today.day_of_week.toString();
  }

  // 星期英文缩写
  function getSystemDayOfWeekEn() as Lang.String {
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    return today.day_of_week.toString();
  }

  // 获取当前年月日用-连接
  function getSystemYearMonthDay() as Lang.String {
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    return today.year + "-" + today.month + "-" + today.day;
  }

  // 获取当前心率
  function getSystemHeartRate() as Lang.String {
    var heartRate = Activity.getActivityInfo().currentHeartRate;
    return heartRate ? heartRate.toString() : "0";
  }

  // 获取当前步数
  function getSystemStepCount() as Lang.String {
    var info = ActivityMonitor.getInfo();
    return info.steps ? info.steps.toString() : "0";
  }

  // 获取当前电量百分比
  function getSystemBattery() as Lang.String {
    var battery = System.getSystemStats().battery;
    return battery.format("%d");
  }

  // 电量剩余天数
  function getSystemBatteryLife() as Lang.String {
    return System.getSystemStats().batteryInDays.format("%d");
  }

  // 正在充电
  function getSystemCharging() as Lang.Boolean {
    return System.getSystemStats().charging;
  }

  // 获取设备宽度
  function getSystemWidth(dc as Graphics.Dc) as Lang.String {
    return dc.getWidth().format("%d");
  }

  // 获取设备高度
  function getSystemHeight(dc as Graphics.Dc) as Lang.String {
    return dc.getHeight().format("%d");
  }

  // 是否连接到手机
  function getSystemConnected() as Lang.Boolean {
    return System.getDeviceSettings().phoneConnected;
  }

  // 用小球画时分秒
  function drawTimeBalls(dc) {
    // 小时颜色
    var hourColor = Application.Properties.getValue("HourColor") as Number;
    // 小时半径
    var hourRadius = 4;
    // 分钟颜色
    var minuteColor = Application.Properties.getValue("MinuteColor") as Number;
    // 分钟半径
    var minuteRadius = 4;
    // 秒颜色
    var secondColor = Application.Properties.getValue("SecondColor") as Number;
    // 秒半径
    var secondRadius = 4;

    var centerX = dc.getWidth() / 2;
    var centerY = dc.getHeight() / 2;
    var radius = dc.getWidth() / 2;
    var hourHandLength = radius - hourRadius;
    var minuteHandLength = radius - minuteRadius;
    var secondHandLength = radius - secondRadius;

    // 获取当前时间
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    var minutes = clockTime.min;
    var seconds = clockTime.sec;

    // 计算时针角度
    // 计算分钟数占 12 的比例，向下取整
    var minuteRatio = Math.floor(minutes / 12);
    // 计算小时数，加上分钟的偏移量
    var hour = (hours % 12) + minuteRatio / 5.0; // 每个小刻度代表 1/5 小时
    // 计算小时角度
    var hourAngle = (hour * Math.PI) / 6; // 每小时 30 度

    // 计算分针角度
    var minuteAngle = (minutes * Math.PI) / 30; // 每分钟 6 度

    // 计算秒针角度
    var secondAngle = (seconds * Math.PI) / 30; // 每秒钟 6 度

    // 计算时针末端坐标
    var hourX = centerX + hourHandLength * Math.sin(hourAngle);
    var hourY = centerY - hourHandLength * Math.cos(hourAngle);

    // 计算分针末端坐标
    var minuteX = centerX + minuteHandLength * Math.sin(minuteAngle);
    var minuteY = centerY - minuteHandLength * Math.cos(minuteAngle);

    // 计算秒针末端坐标
    var secondX = centerX + secondHandLength * Math.sin(secondAngle);
    var secondY = centerY - secondHandLength * Math.cos(secondAngle);

    // 绘制时针小球
    dc.setColor(hourColor, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(hourX, hourY, hourRadius);

    // 绘制分针小球
    dc.setColor(minuteColor, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(minuteX, minuteY, minuteRadius);

    // 绘制秒针小球
    dc.setColor(secondColor, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(secondX, secondY, secondRadius);
  }
}
