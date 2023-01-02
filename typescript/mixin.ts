class Sprite {
    name = "";
    x = 0;
    y = 0;
  
    constructor(name: string) {
      this.name = name;
    }
  }

  type Constructor = new (...args: any[]) => {};