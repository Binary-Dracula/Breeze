import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BreezeView extends WatchUi.WatchFace {
  var utils = new BreezeSystemFieldUtils();
  var weatherUtils = new BreezeWeatherUtils();

  function initialize() {
    WatchFace.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    // 调用父类的onUpdate方法来重新绘制布局
    // 这是必需的步骤,因为我们使用了setLayout()来设置视图布局
    // 父类的onUpdate会确保所有drawable组件都被正确渲染
    View.onUpdate(dc);

    // utils.drawMinuteBalls(dc);
    // utils.drawTimeBalls(dc);
    utils.drawSecondBalls(dc);

    // 当前时间
    var time = utils.getSystemTimeWithoutSecond();
    var timeLabel = findDrawableById("Time") as Text;
    timeLabel.setText(time);

    // 当前心率
    var heartRate = utils.getSystemHeartRate();
    var heartRateLabel = findDrawableById("HeartRate") as Text;
    heartRateLabel.setText(heartRate.format("%d"));

    // 当前压力值
    var stress = utils.getStressData();
    var stressLabel = findDrawableById("Stress") as Text;
    stressLabel.setText(stress.format("%d"));

    // 日期
    var date = utils.getSystemDate() as Array<Lang.Number>;
    // 月/日
    var month = date[1];
    var day = date[2];
    var monthAndDay = findDrawableById("MonthAndDay") as Text;
    monthAndDay.setText(month.format("%d")+"/"+day.format("%d"));
    // 星期
    var week = utils.getSystemDayOfWeekEn();
    var weekLabel = findDrawableById("Week") as Text;
    weekLabel.setText(week);

    // 卡路里
    var calories = utils.getTodayCalories();
    var caloriesLabel = findDrawableById("Calories") as Text;
    caloriesLabel.setText(calories.format("%d") + "kCal");

    // 步数
    var steps = utils.getSystemStepCount();
    var stepsLabel = findDrawableById("Steps") as Text;
    stepsLabel.setText(steps.format("%d"));

    // 身体电量
    var bodyBattery = utils.getBodyBattery();
    var bodyBatteryLabel = findDrawableById("BodyBattery") as Text;
    bodyBatteryLabel.setText(bodyBattery.format("%d"));

    // 剩余电量
    var battery = utils.getSystemBattery() as Lang.Float;
    // 剩余天数
    var batteryLife = utils.getSystemBatteryLife() as Lang.Float;
    var batteryLabel = findDrawableById("WatchBattery") as Text;
    batteryLabel.setText((battery).format("%d") + "%" + " / " + batteryLife.format("%d") + "d");

    // 当前温度
    var currentTemperature = weatherUtils.getCurrentTemperature();
    var temperatureLabel = findDrawableById("Temperature") as Text;
    temperatureLabel.setText(currentTemperature.format("%d") + "°");

    // 是否链接到手机
    var isPhoneConnected = utils.getSystemConnected() as Lang.Boolean;
    var bluetoothDrawable = findDrawableById("Bluetooth") as Bitmap;
    if (isPhoneConnected) {
      bluetoothDrawable.setBitmap(Rez.Drawables.Bluetooth);
    } else {
      bluetoothDrawable.setBitmap(Rez.Drawables.BluetoothDisabled);
    }
  }

  function onPartialUpdate(dc) {
    
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
