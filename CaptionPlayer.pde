class CaptionPlayer {
  Caption[] captions;

  CaptionPlayer(String fileName) {
    String[] lines = loadStrings(fileName);

    this.captions = new Caption[lines.length - 1];
    for (int i=0; i<captions.length; i++)
      captions[i] = new Caption(lines[i+1]);
  }
}


class Caption {
  int time;
  String content;


  Caption(String s) {
    int commaIdx = s.indexOf(",");

    this.time = Integer.parseInt(s.substring(0, commaIdx));
    this.content = s.substring(commaIdx+1, s.length());

    println(time, content);
  }
}
