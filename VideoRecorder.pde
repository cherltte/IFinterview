VideoExport videoExport;


class VideoRecorder {
    final float movieFPS = 30;

    VideoRecorder() {
        //initialize export
        videoExport = new VideoExport(sketch);
        videoExport.setFrameRate(movieFPS);
        // videoExport.setAudioFileName("test-sound.mp3");
        // videoExport.startMovie();
    }

    void update(){
        videoExport.saveFrame();
    }
}