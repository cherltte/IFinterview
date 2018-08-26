class VideoRecorder {
    VideoExport videoExport;
    private int startMillis;
    private int savedFrames;

    VideoRecorder() {
        videoExport = new VideoExport(sketch, "save/" + settings.titles[0] + "/" + settings.titles[1] + "/" + settings.titles[0] + "_" + settings.titles[2] + ".mp4");
        videoExport.setFrameRate(FRAMERATE);
        videoExport.setDebugging(false);

        startMillis = -1;
    }

    void update() {
        if (startMillis == -1)
            return;

        int framesToSave = floor((millis() - startMillis) / 1000.0 * FRAMERATE) - savedFrames;
        println(frameRate, framesToSave);
 
        for (int i=0; i<framesToSave; i++) {
            videoExport.saveFrame();
            savedFrames++;
        }
    }


    public void start() {
        videoExport.startMovie();

        startMillis = millis();
        savedFrames = 0;
    }


    public void end() {
        videoExport.endMovie();
    }
}
