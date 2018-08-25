import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.video.*;
import com.hamoid.*;
import controlP5.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

final boolean SHOW_OPERATOR = true;

ControlP5 controlP5, controlP5_setup;

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
    // audioController = new AudioController();
    videoController1 = new VideoController("operator_interview.mov", "Operator", 1);
    videoController2 = new VideoController("visitor_interview.mov", "Visitor", 5);
    // videoRecorder = new VideoRecorder();
    captionPlayer1 = new CaptionPlayer("log.csv", "Operator", 0);
    captionPlayer2 = new CaptionPlayer("log.csv", "Visitor", 4);
    playController = new PlayController();
    setInterviewController = new SetInterviewController();
    frameRate(FRAMERATE);
    settings.isCompleted = true;
}

void draw() {
    background(0);
    switch (settings.mode) {
        case (0):
            setupInterview();
            break;
        case (1):
            processInterview();
            break;
    }
}

void setupInterview() {
    setInterviewController.draw();
}

void processInterview() {
    playController.draw();
    audioController.display();
    videoController1.display();
    videoController2.display();
    controlP5.draw();
    captionPlayer1.draw();
    captionPlayer2.draw();
    for (Window win: windows)
        win.display();

    for (Indicator indicator: windows[3].indicators)
        indicator.draw();
    
    if (!recorded)
        videoRecorder.update();
}

void keyReleased() {
    if (!settings.isCompleted || !setInterviewController.isCompleted)
        return;

    if (!recorded && key == 'r') {
        if (recorder.isRecording()) {
            recorded = true;
            recorder.endRecord();
            videoExport.endMovie();
            delay(10);
            exit();
        } else {
            videoExport.startMovie();
            recorder.beginRecord();
        }
    }

    if (key == ' ')
        playController.playToggle.setValue(!playController.isPlaying);

}