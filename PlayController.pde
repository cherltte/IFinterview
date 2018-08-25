 public class PlayController {
   private int duration;
   private boolean isPlaying;
   private int playStartTime;

   private Toggle playToggle;
   private Slider timeSlider;
   private Slider syncBigSlider1, syncBigSlider2;
   private Slider syncSlider1, syncSlider2;

   private final Textlabel[] playAnnotation = new Textlabel[2];
   private final String[] playText = {
     "PAUSE: Press the [SPACEBAR] to stop playing.",
     "PLAY: Press the [SPACEBAR] to start playing."
   };


   PlayController() {

     this.isPlaying = false;
     this.duration = int(FRAMERATE * 12 * 60);
     this.playStartTime = 0;

     this.playToggle = controlP5.addToggle("playToggle")
       .setPosition(windows[3].xy.x + windows[2].PD, windows[3].xy.y + windows[3].PD)
       .setSize(int(windows[3].size.y - windows[2].PD * 2), int(windows[3].size.y - windows[3].PD * 2))
       .setCaptionLabel("play/stop")
       //  .setLabelVisible(false)
       .plugTo(this);

     this.timeSlider = controlP5.addSlider("timeSlider")
       .setBroadcast(false)
       .setPosition(windows[2].xy.x, windows[2].xy.y)
       .setSize(width - windows[2].PD * 2, int(windows[2].sliderW*2.5))
       .setRange(0, duration)
       .setColorForeground(color(255, 180))
       .setColorBackground(color(255, 80))
       .setLabelVisible(false)
       .plugTo(this)
       .setBroadcast(true);
       
     int movieSize = 398;
     int PD = 8;
     float[] x = {
       windows[1].xy.x,
       windows[5].xy.x
     };
     float[] y = {
       windows[1].xy.y + movieSize + PD / 2,
       windows[5].xy.y + movieSize + PD / 2
     };

     if (SHOW_OPERATOR)
       this.syncBigSlider1 = controlP5.addSlider("syncBigSlider1")
       .setBroadcast(false)
       .setPosition(x[0], y[0])
       .setSize(int(windows[1].size.x), int(windows[1].sliderW))
       .setRange(-60, 60)
       .setColorForeground(color(255, 180))
       .setColorBackground(color(255, 80))
       .setLabelVisible(false)
       .plugTo(this)
       .setBroadcast(true);

     this.syncBigSlider2 = controlP5.addSlider("syncBigSlider2")
       .setBroadcast(false)
       .setPosition(x[1], y[1])
       .setSize(int(windows[5].size.x), int(windows[5].sliderW))
       .setRange(-60, 60)
       .setColorForeground(color(255, 180))
       .setColorBackground(color(255, 80))
       .setLabelVisible(false)
       .plugTo(this)
       .setBroadcast(true);

     if (SHOW_OPERATOR)
       this.syncSlider1 = controlP5.addSlider("syncSlider1")
       .setBroadcast(false)
       .setPosition(x[0], windows[1].xy.y + windows[1].sliderW + windows[1].PD)
       .setSize(int(windows[1].size.x), int(windows[1].sliderW))
       .setRange(-120, 120)
       .setColorForeground(color(255, 180))
       .setColorBackground(color(255, 80))
       .setLabelVisible(false)
       .plugTo(this)
       .setBroadcast(true);

     this.syncSlider2 = controlP5.addSlider("syncSlider2")
       .setBroadcast(false)
       .setPosition(x[0], windows[5].xy.y + windows[5].sliderW + windows[5].PD)
       .setSize(int(windows[5].size.x), int(windows[5].sliderW))
       .setRange(-120, 120)
       .setColorForeground(color(255, 180))
       .setColorBackground(color(255, 80))
       .setLabelVisible(false)
       .plugTo(this)
       .setBroadcast(true);
     for (int i = 0; i < playAnnotation.length; i++)
       playAnnotation[i] = new Textlabel(controlP5, playText[i], int(windows[3].xy.x + (windows[3].size.y + windows[3].PD) * 2), int(windows[3].xy.y + windows[3].PD * 4));
   }


   public void draw() {
     if (round(timeSlider.getValue()) == duration) {
       playToggle.setValue(false);
     }

     if (isPlaying) {
       timeSlider
         .setBroadcast(false)
         .setValue((millis() - playStartTime) / 1000.0 * FRAMERATE)
         .setBroadcast(true);

       captionPlayer1.update();
       captionPlayer2.update();

       playAnnotation[0].draw(sketch);
     } else {
       playAnnotation[1].draw(sketch);
     }

     pushStyle();
     textSize(11);
     float time = timeSlider.getValue() / FRAMERATE;
     String text = String.format("%02d:%05.2f", int(time) / 60, time % 60);
     text(text, windows[2].xy.x, windows[2].xy.y + windows[2].sliderW*2.5 + 8);
     popStyle();
   }


   public void playToggle(boolean theValue) {
     this.isPlaying = theValue;

     if (isPlaying) {
       videoController1.play();
       videoController2.play();
       playStartTime = millis();
     } else {
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


   public void syncBigSlider1(int theValue) {
     syncSlider(theValue, int(syncSlider1.getValue()), videoController1);
   }


   public void syncBigSlider2(int theValue) {
     syncSlider(theValue, int(syncSlider2.getValue()), videoController2);
   }


   public void syncSlider1(int theValue) {
     syncSlider(int(syncBigSlider1.getValue()), theValue, videoController1);
   }


   public void syncSlider2(int theValue) {
     syncSlider(int(syncBigSlider2.getValue()), theValue, videoController2);
   }


   public void syncSlider(int bigValue, int theValue, VideoController targetVideoController) {
     playToggle.setValue(false);

     targetVideoController.sync(int(bigValue * FRAMERATE) + theValue);
   }
 }
