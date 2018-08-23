Window[] windows;

class SETTING {
    private final int NUM_WINS = 8;
    private final int NUM_DIVISION = 22;
    private final int PD = 8;
    private final int[] NUM_WIN_SIZE = {
        3,
        14,
        2,
        3,
        3,
        14,
        2,
        3
    };
    private final int[] NUM_WINMODE = {
        0,
        1,
        3,
        2,
        0,
        1,
        4,
        4
    };
    private final String title;

    SETTING() {
        int d = day();
        int m = month();
        int y = year();
        int h = hour();
        title = "Interview_" + String.valueOf(m) + "." + String.valueOf(d) + "." + String.valueOf(y) + "." + String.valueOf(h);
        controlP5 = new ControlP5(sketch);
        controlP5.setAutoDraw(false);
        smooth();
        windows();
    }

    void windows() {
        PVector winPos;
        int winW;
        int[] winH = new int[NUM_WINS];
        windows = new Window[NUM_WINS];

        for (int i = 0; i < windows.length; i++) {
            int unit = (height - PD * 5) / NUM_DIVISION;
            winH[i] = unit * NUM_WIN_SIZE[i];
        }

        for (int i = 0; i < windows.length; i++) {
            int indx = i % (NUM_WINS / 2);
            int x = (i < NUM_WINS / 2) ? PD : width / 2 + PD;
            int y = PD * (indx + 1);
            for (int j = 0; j < indx; j++)
                y = y + winH[j];

            winW = (width - PD * 4) / 2;
            winPos = new PVector(x, y);
            windows[i] = new Window(i, winPos, winW, winH[i], NUM_WINMODE[i]);
        }

        controlP5.addTextfield("interview#")
            .setPosition(windows[3].xy.x + windows[3].size.x - 200, windows[3].xy.y + 5 * 8)
            .setSize(200, 20);

    }
}
public void input(String theText) {
    // automatically receives results from controller input
    println("a textfield event for controller 'input' : " + theText);
}