import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Math;

// 绘制一个弧形的实时心率
class BreezeHeartRate extends WatchUi.Drawable {

    var breezeSystemFieldUtils = new BreezeSystemFieldUtils();

    function initialize() {
        // Initialization code here
    }

    function draw(dc as Dc) as Void {
        // Drawing code here
        drawHeartRateArc(dc);
    }
    
    function drawHeartRateArc(dc as Dc) {
        var heartRate = breezeSystemFieldUtils.getSystemHeartRate();

        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = centerX - 20;
        var startAngle = 150;
        var sweepAngle = 30;
        var count = 4;

        dc.setPenWidth(4);
        for(var i = 0; i<count; i++) {
            switch(i) {
                case 0:
                    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
                    break;
                case 1:
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                    break;
                case 2:
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
                    break;
                case 3:
                    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
                    break;
            }
            dc.drawArc(centerX, centerY, radius,Graphics.ARC_CLOCKWISE, startAngle, startAngle - sweepAngle);
            startAngle -= sweepAngle;
        }
    }
}