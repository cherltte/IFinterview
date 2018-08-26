class VideoRecorder {
    VideoExport videoExport;

    VideoRecorder() {
        videoExport = new VideoExport(sketch, "save/" + settings.titles[0] + "/" + settings.titles[1] + "/" + settings.titles[0] + "_" + settings.titles[2] + ".mp4");
        videoExport.setFrameRate(FRAMERATE);
        videoExport.setDebugging(false);
    }

    void update() {
        videoExport.saveFrame();
    }


    public void start() {
        videoExport.startMovie();
    }


    public void end() {
        videoExport.endMovie();
    }
}
