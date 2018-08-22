class CaptionPlayer {
  Caption[] captions;
  List<Caption> displayingCaptions;
  static final int DISPLAYING_TIME = 60;
  final int duration;
  int currentTime;
  int nextCaptionIdx;

  CaptionPlayer(String fileName) {
    String[] lines = loadStrings(fileName);

    this.captions = new Caption[lines.length - 1];
    for (int i=0; i<captions.length; i++)
      captions[i] = new Caption(lines[i+1]);

    this.duration = captions[captions.length-1].time;

    this.displayingCaptions = new ArrayList<Caption>();

    jump(0);
  }


  void draw() {
    float x = windows[0].xy.x + windows[0].PD;
    float y = windows[0].xy.y + windows[0].PD + 16;
    for (Caption c : displayingCaptions) {
      c.display(x, y);
      y += 16;
    }
  }


  void play() {
    currentTime++;

    while(!displayingCaptions.isEmpty()) {
      Caption c = displayingCaptions.get(0);

      if (c.time <= currentTime - DISPLAYING_TIME)
        displayingCaptions.remove(0);
      else
        break;
    }

    for (int i=nextCaptionIdx; i<captions.length; i++) {
      Caption c = captions[i];

      if (c.time <= currentTime) {
        displayingCaptions.add(c);
        nextCaptionIdx = i+1;
      }
      else
        break;
    }
  }


  void jump(int time) {
    time = constrain(time, 0, duration);

    currentTime = time;

    displayingCaptions.clear();
    for (int i=0; i<captions.length; i++) {
      Caption c = captions[i];
      if ((c.time > currentTime - DISPLAYING_TIME) && (c.time <= currentTime)) {
        displayingCaptions.add(c);
        nextCaptionIdx = i+1;
      }
    }
  }
}


class Caption {
  int time;
  String content;


  Caption(String s) {
    int commaIdx = s.indexOf(",");

    this.time = Integer.parseInt(s.substring(0, commaIdx));
    this.content = s.substring(commaIdx+1, s.length());
  }


  void display(float x, float y) {
    pushStyle();
    textSize(12);
    text(content, x, y);
    popStyle();
  }
}
