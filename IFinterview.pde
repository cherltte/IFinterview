import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.video.*;
import com.hamoid.*;
import controlP5.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

ControlP5 controlP5;

PApplet sketch = this;

SETTING settings;
PlayController playController;
AudioController audioController;
VideoController videoController1, videoController2;
VideoRecorder videoRecorder;
CaptionPlayer captionPlayer1, captionPlayer2;
final float FRAMERATE = 30.0;

public void settings() {
    fullScreen();
}
void setup() {
    settings = new SETTING();
    playController = new PlayController();
    audioController = new AudioController();
    videoController1 = new VideoController("processing-movie.mov", 1);
    videoController2 = new VideoController("processing-movie2.mp4", 5);
    videoRecorder = new VideoRecorder();
    captionPlayer1 = new CaptionPlayer("024358.csv", "Operator", 0);
    captionPlayer2 = new CaptionPlayer("024358.csv", "Visitor", 4);
    frameRate(FRAMERATE);
}

void draw() {
    background(0);
    playController.draw();
    audioController.display();
    videoController1.display();
    videoController2.display();
    controlP5.draw();
    videoRecorder.update();
    captionPlayer1.draw();
    captionPlayer2.draw();
    for (Window win: windows)
        win.display();

    for (Indicator indicator: windows[3].indicators)
        indicator.draw();
}

void keyReleased() {
    if (!recorded && key == 'r') {
        if (recorder.isRecording()) {
            recorder.endRecord();
            recorded = true;

        } else {
            videoExport.startMovie();
            recorder.beginRecord();
        }
    }
    if (recorded && key == 's') {
        if (player != null) {
            videoExport.endMovie();
            player.unpatch(out);
            player.close();
        }
        player = new FilePlayer(recorder.save());
        player.patch(out);
        // player.play();
    }
    if (key == ' ') 
        playController.isPlaying =! playController.isPlaying;
        
}