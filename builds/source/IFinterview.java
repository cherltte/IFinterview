import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.ugens.*; 
import processing.video.*; 
import com.hamoid.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class IFinterview extends PApplet {







ControlP5 controlP5;

PApplet sketch = this;

SETTING settings;
AudioController audioController;
VideoController videoController;

public void settings() {
    fullScreen();
}
public void setup() {
    settings = new SETTING();
    audioController = new AudioController();
    videoController = new VideoController();
}

public void draw() {
    background(0);
    stroke(255);
    controlP5.draw();
    audioController.display();
    videoController.display();
    videoController.update();
    for (Window win: windows)
        win.display();
}

public void keyReleased() {

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
Minim minim;
// for recording
AudioInput in ;
AudioRecorder recorder;
boolean recorded;

// for playing back
AudioOutput out;
FilePlayer player;

class AudioController {
    private final int PD = 8;
    AudioController() {
        minim = new Minim(sketch);

        // get a stereo line-in: sample buffer length of 2048
        // default sample rate is 44100, default bit depth is 16
        in = minim.getLineIn(Minim.STEREO, 2048);

        // create an AudioRecorder that will record from in to the filename specified.
        // the file will be located in the sketch's main folder.
        recorder = minim.createRecorder( in , "myrecording.wav");

        // get an output we can playback the recording on
        out = minim.getLineOut(Minim.STEREO);

    }
    public void display() {
        // draw the waveforms
        // the values returned by left.get() and right.get() will be between -1 and 1,
        // so we need to scale them up to see the waveform
        // in.left.size() - 1
        for (int i = 0; i < windows[7].size.x; i++) {
            int scale = 40;
            int baseY = (int)windows[7].size.y / 2;
            float x1 = windows[7].xy.x + i;
            float x2 = windows[7].xy.x + i + 1;
            float y1 = windows[7].xy.y + baseY + in.left.get(i) * scale;
            float y2 = windows[7].xy.y + baseY + in.left.get(i + 1) * scale;
            line(x1, y1, x2, y2);
            // line(windows[7].xy.x + i, 150 + in .right.get(i) * 50, windows[7].xy.x + i + 1 - PD, 150 + in .right.get(i + 1) * 50);
        }

        if (recorder.isRecording()) {
            text("Now recording, press the r key to stop recording.", 5, 15);
        } else if (!recorded) {
            text("Press the r key to start recording.", 5, 15);
        } else {
            text("Press the s key to save the recording to disk and play it back in the sketch.", 5, 15);
        }
    }
}
Window[] windows;

class SETTING {
    private final int NUM_WINS = 8;
    private final int NUM_DIVISION = 22;
    private final int PD = 8;
    private final int[] NUM_WIN_SIZE = {
        3,
        14,
        2,
        3,
        3,
        14,
        2,
        3
    };
    private final int[] NUM_WINMODE = {
        0,
        1,
        3,
        2,
        0,
        1,
        4,
        4
    };

    SETTING() {
        controlP5 = new ControlP5(sketch);
        controlP5.setAutoDraw(false);
        windows();
    }

    public void windows() {
        PVector winPos;
        int winW;
        int[] winH = new int[NUM_WINS];
        windows = new Window[NUM_WINS];

        for (int i = 0; i < windows.length; i++) {
            int unit = (height - PD * 3) / NUM_DIVISION;
            winH[i] = unit * NUM_WIN_SIZE[i];
        }

        for (int i = 0; i < windows.length; i++) {
            int indx = i % (NUM_WINS / 2);
            int x = (i < NUM_WINS / 2) ? PD : width / 2 + PD;
            int y = PD * (indx + 1);
            for (int j = 0; j < indx; j++)
                y = y + winH[j];

            winW = (width - PD * 4) / 2;
            winPos = new PVector(x, y);
            windows[i] = new Window(i, winPos, winW, winH[i], NUM_WINMODE[i]);
        }

    }
}
Movie views[] = new Movie[2];
VideoExport videoExport;

class VideoController {
    float movieFPS = 30;
    float soundDuration = 10.03f; // in seconds

    VideoController() {
        //initialize import
        String [] videoName = {
            "processing-movie.mp4",
            "processing-movie2.mp4"
        };
        
        for (int i = 0; i < 2; i++) {
            views[i] = new Movie(sketch, videoName[i]);
            views[i].play();
        }

        //initialize export
        videoExport = new VideoExport(sketch);
        videoExport.setFrameRate(movieFPS);
        // videoExport.setAudioFileName("test-sound.mp3");
        // videoExport.startMovie();
    }
    public void display() {
        //draw imported movie
        image(views[0], windows[1].xy.x, windows[1].xy.y);
        image(views[1], windows[5].xy.x, windows[5].xy.y);
    }

    public void update(){
        videoExport.saveFrame();
    }
}

public void movieEvent(Movie m) {
    m.read();
}
Range navi;
class Window {
    PVector size, xy;
    int indx;
    private final int sliderW = 20;
    private final int PD = 8;
    private final int[] recordColor = {
        100,
        20,
        250
    };
    private final int[] playColor = {
        200,
        20,
        100
    };
    Window(int indx, PVector xy, int w, int h, int mode) {
        this.xy = xy;
        this.indx = indx;
        size = new PVector(w, h);
        cp5(mode);
    }
    public void cp5(int mode) {
        switch (mode) {
            case (0):
                naviController(mode);
                break;
            case (1):
                naviController(mode);
                volumeController();
                break;
            case (2):
                playController();
                break;
            case (3):
                naviController(mode);
                break;
            case (4):
                break;
        }
    }

    public void display() {
        pushStyle();
        stroke(80);
        noFill();
        rect(xy.x, xy.y, size.x, size.y);
        fill(250, 0, 0);
        text(indx, xy.x, xy.y);
        popStyle();
    }

    public void naviController(int mode) {
        int x = 0;
        int y = 0;
        int w = 0;
        switch (mode) {
            case (0):
                x = (int) xy.x;
                y = (int) xy.y;
                w = (int) size.x;
                break;
            case (1):
                x = (int) xy.x;
                y = (int) xy.y;
                w = (int) size.x - sliderW;
                break;
            case (3):
                x = (int) xy.x;
                y = (int) xy.y;
                w = (int) width - PD * 2;
                break;
        }
        controlP5.addSlider("navi" + indx)
            // disable broadcasting since setRange and setRangeValues will trigger an event
            // .setBroadcast(false)
            .setPosition(x, y)
            .setSize(w, sliderW)
            .setRange(0, 1)
            // after the initialization we turn broadcast back on again
            // .setBroadcast(true)
            .setColorForeground(color(255, 40))
            .setColorBackground(color(255, 40))
            .setLabelVisible(false);
    }

    public void volumeController() {
        controlP5.addSlider("volume" + indx)
            .setPosition(xy.x + size.x - sliderW, xy.y + sliderW)
            .setSize(sliderW, (int) size.y - sliderW)
            .setRange(0, 255)
            .setNumberOfTickMarks(8)
            .setLabelVisible(false)
            .setColorForeground(color(255, 40))
            .setColorBackground(color(255, 40));
    }

    public void playController() {
        int x = (int) xy.x + PD;
        int y = (int) xy.y + PD;
        int btSize = (int) size.y - PD * 2;
        controlP5.addToggle("play" + indx)
            .setPosition(x, y)
            .setSize(btSize, btSize)
            .setCaptionLabel("play/stop")
            // .setLabelVisible(false)
            .setColorActive(color(recordColor[0],recordColor[1],recordColor[2]))
            .setColorBackground(color(recordColor[0],recordColor[1],recordColor[2], 200))
            .setColorForeground(color(recordColor[0],recordColor[1],recordColor[2], 180));
            // .setColorBackground(color(255, 40));
        x = x + btSize + PD;
        controlP5.addToggle("record" + indx)
            .setPosition(x, y)
            .setSize(btSize, btSize)
            .setCaptionLabel("record")
            // .setLabelVisible(false)
            .setColorActive(color(playColor[0],playColor[1],playColor[2]))
            .setColorBackground(color(playColor[0],playColor[1],playColor[2], 200))
            .setColorForeground(color(playColor[0],playColor[1],playColor[2], 180));
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "IFinterview" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
