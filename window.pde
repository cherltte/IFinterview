class Window {
    PVector size, xy;
    int indx;
    Window(int indx, PVector xy, int w, int h) {
        this.xy = xy;
        this.indx = indx;
        size = new PVector(w, h);
    }

    void display() {
        pushStyle();
        stroke(240);
        noFill();
        rect(xy.x, xy.y, size.x, size.y);
        fill(250, 0, 0);
        text(indx, xy.x, xy.y);
        popStyle();
    }
}