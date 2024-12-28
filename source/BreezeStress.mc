import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Math;

class BreezeStress extends WatchUi.Drawable {

    var breezeSystemFieldUtils = new BreezeSystemFieldUtils();

    function initialize() {
        Drawable.initialize({});
        
    }

    function draw(dc as Dc) as Void {
        drawPressureArc(dc);
        onStressChanged(dc);
    }

    function drawPressureArc(dc as Dc) {
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = centerX - 20;
        var startAngle = 330;
        var sweepAngle = 30;
        var count = 4;

        dc.setPenWidth(4);
        for(var i = 0; i<count; i++) {
            switch(i) {
                case 3:
                    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
                    break;
                case 2:
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                    break;
                case 1:
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
                    break;
                case 0:
                    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
                    break;
            }
            dc.drawArc(centerX, centerY, radius,Graphics.ARC_CLOCKWISE, startAngle, startAngle - sweepAngle);
            startAngle -= sweepAngle;
        }
    }

    function onStressChanged(dc as Dc) {
        // 获取当前压力值
        var stress = breezeSystemFieldUtils.getStressData();
        // 压力值时0-100
        // 角度时60度-180度
        // 1压力值是1.2度
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var radius = centerX - 18;
        var offset = 2;
        var startAngle = 150;
        var angle = startAngle - stress * 120 / 100;
        
        var position  = breezeSystemFieldUtils.getPosition(centerX, centerY, radius, angle, offset);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(4);
        dc.drawLine(position[0][0], position[0][1], position[1][0], position[1][1]);
    }
}