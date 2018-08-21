import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.video.*;
import com.hamoid.*;
import controlP5.*;

ControlP5 controlP5;

PApplet sketch = this;

SETTING settings;
AudioController audioController;
VideoController videoController;

public void settings() {
    fullScreen();
}
void setup() {
    settings = new SETTING();
    audioController = new AudioController();
    videoController = new VideoController();
}

void draw() {
    background(0);
    stroke(255);
    controlP5.draw();
    audioController.display();
    videoController.display();
    videoController.update();
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