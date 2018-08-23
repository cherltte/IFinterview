VideoExport videoExport;

class VideoRecorder {
    final float movieFPS = 30;

    VideoRecorder() {
        //initialize export
        videoExport = new VideoExport(sketch, settings.title + ".mp4");
        videoExport.setFrameRate(movieFPS);
        // videoExport.setAudioFileName("test-sound.mp3");
        // videoExport.startMovie();
    }

    void update() {
        videoExport.saveFrame();
    }
}