import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class DashedLine extends WatchUi.Drawable {

  private var _index = 0;

  function initialize(params as Dictionary) {
     Drawable.initialize(params);
    _index = params.get(:index);
  }

  function draw(dc as Dc) as Void {
    drawDashedLine(dc);
  }

  function drawDashedLine(dc as Graphics.Dc) as Void {
    var width = dc.getWidth();
    var height = dc.getHeight();

    var count = 7;
    var radius = 3;
    var interval = 6 * radius;
    var x = width * 0.29;
    var y = 0;

    switch (_index) {
      case 0:
        y = height * 0.41;
        break;
      case 1:
        y = height * 0.55;
        break;
      case 2:
        y = height * 0.69;
        break;
    }

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    for (var i = 0; i < count; i++) {
      dc.fillCircle(x, y, radius);
      x = x + interval;
    }
  }
}
