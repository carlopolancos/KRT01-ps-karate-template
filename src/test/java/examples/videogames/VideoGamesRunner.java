package examples.videogames;

import com.intuit.karate.junit5.Karate;

class VideoGamesRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("videogames").relativeTo(getClass());
    }    

}
