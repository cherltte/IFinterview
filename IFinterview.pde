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
    stroke(255);
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
}

void keyReleased() {

    if (!recorded && key == 'r') {
        // to indicate that you want to start or stop capturing audio data, 
        // you must callstartRecording() and stopRecording() on the AudioRecorder object. 
        // You can start and stop as many times as you like, the audio data will 
        // be appended to the end of to the end of the file. 
        if (recorder.isRecording()) {
            recorder.endRecord();
            recorded = true;

        } else {
            videoExport.startMovie();
            recorder.beginRecord();
        }
    }
    if (recorded && key == 's') {
        // we've filled the file out buffer, 
        // now write it to a file of the type we specified in setup
        // in the case of buffered recording, 
        // this will appear to freeze the sketch for sometime, if the buffer is large
        // in the case of streamed recording, 
        // it will not freeze as the data is already in the file and all that is being done
        // is closing the file.
        // save returns the recorded audio in an AudioRecordingStream, 
        // which we can then play with a FilePlayer
        if (player != null) {
            videoExport.endMovie();
            player.unpatch(out);
            player.close();
        }
        player = new FilePlayer(recorder.save());
        player.patch(out);
        player.play();
    }
}