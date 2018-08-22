Range navi;
class Window {
    PVector size, xy;
    int indx;
    private final Integer sliderW = 20;
    private final Integer PD = 8;
    private final int[] recordColor = {
        100,
        20,
        250
    };
    private final int[] playColor = {
        200,
        20,
        100
    };
    Window(int indx, PVector xy, int w, int h, int mode) {
        this.xy = xy;
        this.indx = indx;
        size = new PVector(w, h);
        cp5(mode);
    }
    
    void cp5(int mode) {
        switch (mode) {
            case (0):
                naviController(mode);
                break;
            case (1):
                naviController(mode);
                volumeController();
                break;
            case (2):
                playController();
                break;
            case (4):
                break;
        }
    }

    void display() {
        pushStyle();
        stroke(80);
        noFill();
        rect(xy.x, xy.y, size.x, size.y);
        fill(250, 0, 0);
        text(indx, xy.x, xy.y);
        popStyle();
    }

    void naviController(int mode) {
        int x = 0;
        int y = 0;
        int w = 0;
        switch (mode) {
            case (0):
                x = (int) xy.x;
                y = (int) xy.y;
                w = (int) size.x;
                break;
            case (1):
                x = (int) xy.x;
                y = (int) xy.y;
                w = (int) size.x - sliderW;
                break;
        }
        controlP5.addSlider("navi" + indx)
            // disable broadcasting since setRange and setRangeValues will trigger an event
            // .setBroadcast(false)
            .setPosition(x, y)
            .setSize(w, sliderW)
            .setRange(0, 1)
            // after the initialization we turn broadcast back on again
            // .setBroadcast(true)
            .setColorForeground(color(255, 180))
            .setColorBackground(color(255, 80))
            .setLabelVisible(false);
    }

    void volumeController() {
        controlP5.addSlider("volume" + indx)
            .setPosition(xy.x + size.x - sliderW, xy.y + sliderW)
            .setSize(sliderW, (int) size.y - sliderW)
            .setRange(0, 255)
            .setNumberOfTickMarks(8)
            .setLabelVisible(false)
            .setColorForeground(color(255, 180))
            .setColorBackground(color(255, 80));
    }

    void playController() {
        int x = (int) xy.x + PD;
        int y = (int) xy.y + PD;
        int btSize = (int) size.y - PD * 2;
        controlP5.addToggle("play" + indx)
            .setPosition(x, y)
            .setSize(btSize, btSize)
            .setCaptionLabel("play/stop");
            // .setLabelVisible(false)
            // .setColorActive(color(recordColor[0], recordColor[1], recordColor[2]))
            // .setColorBackground(color(recordColor[0], recordColor[1], recordColor[2], 200))
            // .setColorForeground(color(recordColor[0], recordColor[1], recordColor[2], 180));
        // .setColorBackground(color(255, 40));
        x = x + btSize + PD;
        controlP5.addToggle("record" + indx)
            .setPosition(x, y)
            .setSize(btSize, btSize)
            .setCaptionLabel("record");
            // .setLabelVisible(false)
            // .setColorActive(color(playColor[0], playColor[1], playColor[2]))
            // .setColorBackground(color(playColor[0], playColor[1], playColor[2], 200))
            // .setColorForeground(color(playColor[0], playColor[1], playColor[2], 180));
    }
}