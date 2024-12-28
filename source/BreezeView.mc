import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BreezeView extends WatchUi.WatchFace {
  var utils = new BreezeSystemFieldUtils();

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

    utils.drawMinuteBalls(dc);
    utils.drawTimeBalls(dc);

    // 当前心率
    var heartRate = utils.getSystemHeartRate();
    var heartRateLabel = findDrawableById("HeartRate") as Text;
    heartRateLabel.setText(heartRate.format("%d"));

    // 当前压力值
    var stress = utils.getStressData();
    var stressLabel = findDrawableById("Stress") as Text;
    stressLabel.setText(stress.format("%d"));
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
