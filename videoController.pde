class VideoController {
    float soundDuration = 10.03; // in seconds
    final Movie view;
    final int targetWindow;
    private final float w, h;
    static final int DELAY = 5;
    int syncValue;

    VideoController(String videoName, int targetWindow) {
        this.view = new Movie(sketch, videoName);
        this.targetWindow = targetWindow;
        this.syncValue = 0;

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

        pushStyle();
        textSize(13);
        float time = view.time();
        String text = String.format("%02d:%05.2f (%.2f)", int(time)/60, time, syncValue/FRAMERATE);
        text(text, windows[targetWindow].xy.x, windows[targetWindow].xy.y+windows[targetWindow].size.y);
        popStyle();
    }


    void play() {
        view.play();
    }


    void pause() {
        view.pause();
    }


    void jump(int frame) {
        view.jump((frame + syncValue) / FRAMERATE);
    }


    void sync(int syncValue) {
        view.jump(view.time() + (syncValue - this.syncValue) / FRAMERATE);
        this.syncValue = syncValue;
    }
}

void movieEvent(Movie m) {
    m.read();
}