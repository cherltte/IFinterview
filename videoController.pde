class VideoController {
    float soundDuration = 10.03; // in seconds
    final Movie view;
    final int targetWindow;
    private final float w, h;
    static final int DELAY = 5;
    int syncValue;
    int reservedJump;
    int reservedSync;
    static final int UPDATE_RATE = 10;
    static final int NONE = -10000;

    VideoController(String videoName, int targetWindow) {
        this.view = new Movie(sketch, videoName);
        this.targetWindow = targetWindow;
        this.syncValue = 0;
        this.reservedJump = NONE;
        this.reservedSync = NONE;

        view.play();
        while (view.height == 0 || view.width == 0) delay(DELAY);
        if (view.width > view.height) {
            w = windows[targetWindow].size.x;
            h = (view.height * windows[targetWindow].size.x) / view.width;
        } else {
            h = windows[targetWindow].size.y;
            w = (view.width * windows[targetWindow].size.y) / view.height;
        }
        view.pause();
        view.jump(0);
    }
    void display() {
        //draw imported movie
        image(view, windows[targetWindow].xy.x, windows[targetWindow].xy.y, w, h);

        pushStyle();
        textSize(11);
        float time = view.time();
        String text = String.format("%02d:%05.2f (%.2f)", int(time) / 60, time, syncValue / FRAMERATE);
        text(text, windows[targetWindow].xy.x, windows[targetWindow].xy.y + windows[targetWindow].size.y);
        popStyle();

        if ((frameCount % UPDATE_RATE == 0) && (reservedJump != NONE)) {
            println(reservedJump);
            view.play();
            view.jump((reservedJump + syncValue) / FRAMERATE);
            view.pause();
            reservedJump = NONE;
        }

        if ((frameCount % UPDATE_RATE == 0) && (reservedSync != NONE)) {
            view.play();
            view.jump(view.time() + (reservedSync - this.syncValue) / FRAMERATE);
            view.pause();
            this.syncValue = reservedSync;
            reservedSync = NONE;
        }
    }


    void play() {
        view.play();
    }


    void pause() {
        view.pause();
    }


    void jump(int frame) {
        reservedJump = frame;
    }


    void sync(int syncValue) {
        reservedSync = syncValue;
    }
}

void movieEvent(Movie m) {
    m.read();
}