Window[] windows;

class SETTING {
    private final int NUM_WINS = 8;
    private final int NUM_DIVISION = 22;
    private final int PD = 8;
    private final int[] NUM_WIN_SIZE = {
        3,
        13,
        2,
        4,
        3,
        13,
        2,
        4
    };

    SETTING() {
        windows();
    }

    void windows() {
        PVector winPos;
        int winW;
        int[] winH = new int[NUM_WINS];
        windows = new Window[NUM_WINS];

        for (int i = 0; i < windows.length; i++) {
            int unit = (height - PD * 3) / NUM_DIVISION;
            winH[i] = unit * NUM_WIN_SIZE[i];
        }

        for (int i = 0; i < windows.length; i++) {
            int indx = i % (NUM_WINS / 2);
            int x = (i < NUM_WINS / 2) ? PD : width / 2 + PD;
            int y = PD * (indx + 1);
            for (int j = 0; j < indx; j++)
                y = y + winH[j];

            winW = (width - PD * 3) / 2;
            winPos = new PVector(x, y);
            windows[i] = new Window(i, winPos, winW, winH[i]);
        }

    }
}