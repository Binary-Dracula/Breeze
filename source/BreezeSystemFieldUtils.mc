import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Graphics;
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
            clockTime.sec.format("%02d")
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
}

