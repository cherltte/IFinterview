class VideoController {
    float soundDuration = 10.03; // in seconds
    final Movie view;
    final int targetWindow;
    private final float w, h;
    static final int DELAY = 5;

    VideoController(String videoName, int targetWindow) {
        this.view = new Movie(sketch, videoName);
        this.targetWindow = targetWindow;

        view.play();

        while (view.height == 0 || view.width == 0) delay(DELAY);
        if (view.width > view.height) {
            w = windows[targetWindow].size.x;
            h = (view.height * windows[targetWindow].size.x) / view.width;
        } else {
            h = windows[targetWindow].size.y;
            w = (view.width * windows[targetWindow].size.y) / view.height;
        }
    }
    void display() {
        //draw imported movie
        image(view, windows[targetWindow].xy.x, windows[targetWindow].xy.y, w, h);
    }
}

void movieEvent(Movie m) {
    m.read();
}