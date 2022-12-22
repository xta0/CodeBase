class ComicBookCharactor {
    alias: string;
    health: number;
    strength: number;

    attackFunc(opponent: ComicBookCharactor, attackWith: number) {
        opponent.health -= attackWith
        console.log(`${this.alias} attacked ${opponent.alias}`)
    }
}