class CaptionPlayer {
  Caption[] captions;
  List<Caption> displayingCaptions;
  static final int DISPLAYING_TIME = 60;
  final int duration;
  int targetWindow;
  String targetSubject;
  int currentTime;
  int nextCaptionIdx;

  CaptionPlayer(String fileName, String targetSubject, int targetWindow) {
    String[] lines = loadStrings(fileName);

    this.captions = new Caption[lines.length - 1];
    for (int i=0; i<captions.length; i++)
      captions[i] = new Caption(lines[i+1]);

    this.duration = captions[captions.length-1].time;

    this.displayingCaptions = new ArrayList<Caption>();

    this.targetSubject = targetSubject;

    this.targetWindow = targetWindow;

    jump(0);
  }


  void draw() {
    float x = windows[targetWindow].xy.x + windows[targetWindow].PD;
    float y = windows[targetWindow].xy.y + windows[targetWindow].PD + 16;
    for (Caption c : displayingCaptions) {
      if (!c.subject.equals(targetSubject))
        continue;

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
    nextCaptionIdx = 0;
    for (int i=0; i<captions.length; i++) {
      Caption c = captions[i];
      if (c.time <= currentTime - DISPLAYING_TIME) {
        nextCaptionIdx = i+1;
      }
      else if ((c.time > currentTime - DISPLAYING_TIME) && (c.time <= currentTime)) {
        displayingCaptions.add(c);
        nextCaptionIdx = i+1;
      }
    }
  }
}


class Caption {
  int time;
  String subject;
  String content;


  Caption(String s) {
    int commaIdx = s.indexOf(",");
    int commaIdx2 = s.indexOf(",", commaIdx+1);

    this.time = Integer.parseInt(s.substring(0, commaIdx));
    this.subject = s.substring(commaIdx+1, commaIdx2);
    this.content = s.substring(commaIdx2+1, s.length());
  }


  void display(float x, float y) {
    pushStyle();
    textSize(12);
    text(content, x, y);
    popStyle();
  }
}
