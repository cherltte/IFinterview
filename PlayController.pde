public class PlayController {
  private boolean isPlaying;
  private int duration;

  private Toggle playToggle;
  private Slider timeSlider;


  PlayController() {
    this.isPlaying = false;
    this.duration = 3000;

    this.playToggle = controlP5.addToggle("playToggle")
      .setPosition(windows[3].xy.x+windows[2].PD, windows[3].xy.y+windows[3].PD)
      .setSize(int(windows[3].size.y-windows[2].PD*2), int(windows[3].size.y-windows[3].PD*2))
      .setCaptionLabel("play/stop")
      .setLabelVisible(false)
      .setLabelVisible(false)
      .plugTo(this);

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
      playToggle.setValue(false);
    }

    if (isPlaying) {
      timeSlider
        .setBroadcast(false)
        .setValue(timeSlider.getValue()+1)
        .setBroadcast(true);

      captionPlayer1.play();
      captionPlayer2.play();
    }
  }


  public void playToggle(boolean theValue) {
    this.isPlaying = theValue;

    if (isPlaying) {
      videoController1.play();
      videoController2.play();
    }
    else {
      videoController1.pause();
      videoController2.pause();
    }
  }


  public void timeSlider(int theValue) {
    playToggle.setValue(false);

    captionPlayer1.jump(theValue);
    captionPlayer2.jump(theValue);

    videoController1.jump(theValue);
    videoController2.jump(theValue);
  }
}
