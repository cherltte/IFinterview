Movie views[] = new Movie[2];
VideoExport videoExport;

class VideoController {
    private final float movieFPS = 30;
    private final float soundDuration = 10.03; // in seconds
    private final int PD = 8;

    VideoController() {
        //initialize import
        String[] videoName = {
            "processing-movie.mov",
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
    void display() {
        //draw imported movie
        image(views[0], windows[1].xy.x, windows[1].xy.y, windows[1].size.x, windows[1].size.y);
        image(views[1], windows[5].xy.x, windows[5].xy.y, windows[5].size.x, windows[5].size.y);
    }

    void update() {
        videoExport.saveFrame();
    }
}

void movieEvent(Movie m) {
    m.read();
}