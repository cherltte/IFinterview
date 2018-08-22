class VideoController {
<<<<<<< HEAD
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
=======
    float soundDuration = 10.03; // in seconds
    final Movie view;
    final int targetWindow;

    VideoController(String videoName, int targetWindow) {
        this.view = new Movie(sketch, videoName);
        this.targetWindow = targetWindow;
>>>>>>> 99a6f21358f23ee3616e56f2d88422942cdfe572

        view.play();
    }
    void display() {
        //draw imported movie
<<<<<<< HEAD
        image(views[0], windows[1].xy.x, windows[1].xy.y, windows[1].size.x, windows[1].size.y);
        image(views[1], windows[5].xy.x, windows[5].xy.y, windows[5].size.x, windows[5].size.y);
    }

    void update() {
        videoExport.saveFrame();
=======
        image(view, windows[targetWindow].xy.x, windows[targetWindow].xy.y);
>>>>>>> 99a6f21358f23ee3616e56f2d88422942cdfe572
    }
}

void movieEvent(Movie m) {
    m.read();
}