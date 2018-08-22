public class PlayController {
  private boolean isPlaying;
  private int duration;

  private Toggle playToggle;
  private Slider timeSlider;


  PlayController() {
    this.isPlaying = true;
    this.duration = 3000;

    this.timeSlider = controlP5.addSlider("timeSlider")
      .setBroadcast(false)
      .setPosition(windows[2].xy.x, windows[2].xy.y)
      .setSize(width-windows[2].PD*2, windows[2].sliderW)
      .setRange(0, duration)
      .setColorForeground(color(255, 180))
      .setColorBackground(color(255, 80))
      .setLabelVisible(false)
      .plugTo(this)
      .setBroadcast(true);
  }


  public void draw() {
    if (round(timeSlider.getValue()) == duration) {
      isPlaying = false;
    }

    if (isPlaying) {
      timeSlider
        .setBroadcast(false)
        .setValue(timeSlider.getValue()+1)
        .setBroadcast(true);
    }
  }


  public void timeSlider(int theValue) {
    println(theValue);
  }
}
