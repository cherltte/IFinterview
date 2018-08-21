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
    void display() {
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