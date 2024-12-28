import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Math;

// 绘制一个弧形的实时心率
class BreezeHeartRate extends WatchUi.Drawable {

    var breezeSystemFieldUtils = new BreezeSystemFieldUtils();

    function initialize() {
        Drawable.initialize({});
        // Initialization code here
    }

    function draw(dc as Dc) as Void {
        // Drawing code here
        drawHeartRateArc(dc);
        onHeartRateChanged(dc);
    }
    
    function drawHeartRateArc(dc as Dc) {
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

    function onHeartRateChanged(dc as Dc) {
        var heartRate = breezeSystemFieldUtils.getSystemHeartRate();
        var heartRateForCaculate = heartRate;
        if (heartRateForCaculate <70) {
            heartRateForCaculate = 70;
        }
        if (heartRateForCaculate > 140) {
            heartRateForCaculate = 140;
        }

        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = centerX - 20;
        var offset = 2;
        var startAngle = 210;//3点钟是0度
        // 70-140 10点到2点是120度
        var angle = startAngle + (heartRateForCaculate - 70) * 120 / (140 - 70);

        var position  = breezeSystemFieldUtils.getPosition(centerX, centerY, radius, angle, offset) as Array<Array<Float>>;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(4);
        dc.drawLine(position[0][0], position[0][1], position[1][0], position[1][1]);
    }
}