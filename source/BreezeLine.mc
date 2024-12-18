import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
using Toybox.Math;

class BreezeLine extends WatchUi.Drawable {
  // 小时刻度长
  private var _hourTickLength = 10;
  // 小时刻度宽
  private var _hourStrokeWidth = 4;
  // 小时刻度颜色
  private var _hourStrokeColor = Graphics.COLOR_GREEN;
  // 分钟刻度长
  private var _minuteTickLength = 6;
  // 分钟刻度宽
  private var _minuteStrokeWidth = 2;
  // 分钟刻度颜色
  private var _minuteStrokeColor = Graphics.COLOR_WHITE;
  // 大圆圈宽度
  private var _circleWidth = 1;
  // 大圆圈颜色
  private var _circleColor = Graphics.COLOR_GREEN;
  // 大圆圈和小时刻度的偏移量
  private var _circleOffset = 4;

  // 中心点坐标
  private var _centerX = 0;
  private var _centerY = 0;

  // 半径
  private var _radius = 0;

  // 颜色
  private var _colorTransparent = Graphics.COLOR_TRANSPARENT;

  var utils = new BreezeSystemFieldUtils();

  function initialize() {}

  function draw(dc as Dc) as Void {
    calculatedBase(dc);
    drawMinuteTicks(dc);
    drawCircle(dc);

    utils.drawTimeBalls(dc);
  }

  // 计算基础值
  function calculatedBase(dc as Graphics.Dc) {
    _centerX = dc.getWidth() / 2;
    _centerY = dc.getHeight() / 2;
    _radius = dc.getWidth() / 2;
  }

  function drawMinuteTicks(dc) {
    // 获取当前时间
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    var minutes = clockTime.min;
    var seconds = clockTime.sec;

    // 循环遍历 0 到 59 分钟
    for (var tick = 0; tick < 60; tick++) {
      if (tick == hours % 12 * 5  + Math.floor(minutes / 12) || tick == minutes || tick == seconds) {
      } else {
        // 计算起始点坐标
        var startPoint = computeTickStartPoint(tick);

        // 排除整点刻度
        if (tick % 5 == 0) {
          // 计算结束点坐标，使用缩短的半径
          var endPoint = computeTickEndPoint(tick, _hourTickLength);
          // 设置小时刻度样式
          dc.setColor(_hourStrokeColor, _colorTransparent);
          dc.setPenWidth(_hourStrokeWidth);
          dc.drawLine(startPoint[0], startPoint[1], endPoint[0], endPoint[1]);
        } else {
          // 计算结束点坐标，使用缩短的半径
          var endPoint = computeTickEndPoint(tick, _minuteTickLength);
          // 设置分钟刻度样式
          dc.setColor(_minuteStrokeColor, _colorTransparent);
          dc.setPenWidth(_minuteStrokeWidth);
          dc.drawLine(startPoint[0], startPoint[1], endPoint[0], endPoint[1]);
        }
      }
    }
  }

  // 根据分钟获取刻度起始坐标
  function computeTickStartPoint(tick) {
    // 将分钟转换为角度（每分钟 6 度）
    var angle = (tick * Math.PI) / 30;

    // 计算 x1 坐标
    var x = _centerX + _radius * Math.sin(angle);

    // 计算 y1 坐标
    var y = _centerY - _radius * Math.cos(angle);

    return [x, y];
  }

  /**
   * 根据分钟获取刻度终点坐标
   * offset指刻度长度
   */
  function computeTickEndPoint(tick, offset) {
    // 将分钟转换为角度（每分钟 6 度）
    var angle = (6 * tick * Math.PI) / 180;

    // 计算 x2 坐标，使用缩短的半径
    var x = _centerX + (_radius - offset) * Math.sin(angle);

    // 计算 y2 坐标，使用缩短的半径
    var y = _centerY - (_radius - offset) * Math.cos(angle);

    return [x, y];
  }

  // 画一个圆圈，r = _radius - _hourTickLength
  function drawCircle(dc) {
    dc.setPenWidth(_circleWidth);
    dc.setColor(_circleColor, _colorTransparent);
    dc.drawCircle(
      _centerX,
      _centerY,
      _radius - _hourTickLength - _circleOffset
    );
  }
}
