class VideoController {
    float soundDuration = 10.03; // in seconds
    final Movie view;
    final int targetWindow;

    VideoController(String videoName, int targetWindow) {
        this.view = new Movie(sketch, videoName);
        this.targetWindow = targetWindow;

        view.play();
    }
    void display() {
        //draw imported movie
        image(view, windows[targetWindow].xy.x, windows[targetWindow].xy.y);
    }
}

void movieEvent(Movie m) {
    m.read();
}