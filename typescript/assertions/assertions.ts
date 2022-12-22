interface SuperHero {
    powers: string[];
    saveTheDay: () => void;
}

interface BadGuys {
    badDeeds: string[];
    commitBadDeed: () => void;

}

function saveDayOrBadDeed(guy: SuperHero | BadGuys) {
    // compile time assertions
    if((guy as SuperHero).powers){
        (guy as SuperHero).saveTheDay()
    } else {
        (guy as BadGuys).commitBadDeed()
    }
}