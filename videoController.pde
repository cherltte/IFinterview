Movie views[] = new Movie[2];

class VideoController {
    float soundDuration = 10.03; // in seconds

    VideoController() {
        //initialize import
        String [] videoName = {
            "processing-movie.mp4",
            "processing-movie2.mp4"
        };
        
        for (int i = 0; i < 2; i++) {
            views[i] = new Movie(sketch, videoName[i]);
            views[i].play();
        }
    }
    void display() {
        //draw imported movie
        image(views[0], windows[1].xy.x, windows[1].xy.y);
        image(views[1], windows[5].xy.x, windows[5].xy.y);
    }
}

void movieEvent(Movie m) {
    m.read();
}