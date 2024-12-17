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
  private var _minuteTickLength = 5;
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


  function initialize() {
    
  }

  function draw(dc as Dc) as Void {
    calculatedBase(dc);
    drawHourTick(dc);
    drawMinuteTicks(dc);
    drawCircle(dc);
  }

  // 计算基础值
  function calculatedBase(dc as Graphics.Dc) {
    _centerX = dc.getWidth() / 2;
    _centerY = dc.getHeight() / 2;
    _radius = dc.getWidth() / 2;
  }

  // 画小时刻度
  function drawHourTick(dc as Graphics.Dc) {
    for (var i = 0; i < 12; i++) {
      var start = computeHourTickStartPoint(i);
      var end = computeHourTickEndPoint(i);

      dc.setColor(_hourStrokeColor, _colorTransparent);
      dc.setPenWidth(_hourStrokeWidth);
      dc.drawLine(start[0], start[1], end[0], end[1]);
    }
  }

  function drawMinuteTicks(dc) {
    // 循环遍历 0 到 59 分钟
    for (var minute = 0; minute < 60; minute++) {
      // 排除整点刻度
      if (minute % 5 != 0) {
        // 计算起始点坐标
        var startPoint = computeMinuteTickStartPoint(minute);

        // 计算结束点坐标，使用缩短的半径
        var endPoint = computeMinuteTickEndPoint(minute);

        // 绘制分钟刻度线
        dc.setColor(_minuteStrokeColor, _colorTransparent);
        dc.setPenWidth(_minuteStrokeWidth);
        dc.drawLine(startPoint[0], startPoint[1], endPoint[0], endPoint[1]);
      }
    }
  }

  // 根据小时获取刻度的起始坐标
  function computeHourTickStartPoint(hour) {
    // 将小时转换为角度（每小时 30 度）
    var angle = (hour * Math.PI) / 6;

    // 计算 x1 坐标
    var x1 = _centerX + _radius * Math.sin(angle);

    // 计算 y1 坐标
    var y1 = _centerY - _radius * Math.cos(angle);

    return [x1, y1];
  }

  // 根据小时获取刻度的终点坐标
  function computeHourTickEndPoint(hour) {
    // 将小时转换为角度（每小时 30 度）
    var angle = (hour * Math.PI) / 6;

    // 计算 x2 坐标，使用缩短的半径
    var x2 = _centerX + (_radius - _hourTickLength) * Math.sin(angle);

    // 计算 y2 坐标，使用缩短的半径
    var y2 = _centerY - (_radius - _hourTickLength) * Math.cos(angle);

    return [x2, y2];
  }

  // 根据分钟获取刻度起始坐标
  function computeMinuteTickStartPoint(minute) {
    // 将分钟转换为角度（每分钟 6 度）
    var angle = (minute * Math.PI) / 30;

    // 计算 x1 坐标
    var x1 = _centerX + _radius * Math.sin(angle);

    // 计算 y1 坐标
    var y1 = _centerY - _radius * Math.cos(angle);

    return [x1, y1];
  }

  // 根据分钟获取刻度终点坐标
  function computeMinuteTickEndPoint(minute) {
    // 将分钟转换为角度（每分钟 6 度）
    var angle = (minute * Math.PI) / 30;

    // 计算 x2 坐标，使用缩短的半径
    var x2 = _centerX + (_radius - _minuteTickLength) * Math.sin(angle);

    // 计算 y2 坐标，使用缩短的半径
    var y2 = _centerY - (_radius - _minuteTickLength) * Math.cos(angle);

    return [x2, y2];
  }

  // 画一个圆圈，r = _radius - _hourTickLength
  function drawCircle(dc) {
    dc.setPenWidth(_circleWidth);
    dc.setColor(_circleColor, _colorTransparent);
    dc.drawCircle(_centerX, _centerY, _radius - _hourTickLength - _circleOffset);
  }
}
