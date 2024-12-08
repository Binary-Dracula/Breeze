import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityMonitor;

class BreezeSystemFieldUtils {

    // 获取系统时间
    function getSystemTime() {
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
    function getSystemWeek() {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        return today.day_of_week.toString();
    }

    // 获取当前年月日用-连接
    function getSystemYearMonthDay() {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        return today.year + "-" + today.month + "-" + today.day;
    }

    // 获取当前心率
    function getSystemHeartRate() {
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        return heartRate ? heartRate.toString() : "0";
    }
    
    // 获取当前步数
    function getSystemStepCount() {
        var info = ActivityMonitor.getInfo();
        return info.steps ? info.steps.toString() : "0";
    }

    // 获取当前电量百分比
    function getSystemBattery() as Lang.String {
        var battery = System.getSystemStats().battery;
        return battery.format("%d");
    }

    // 
}