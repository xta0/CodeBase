type DummyPlatform = {
    [key: string]: string
}
class Singleton {
    private static instance: Singleton;
    private paltform:DummyPlatform = {arch:"Apple"}
    private constructor(readonly platform: DummyPlatform) {}
    static getInstance<T extends DummyPlatform>(val:T) {
      if (!Singleton.instance) {
        Singleton.instance = new Singleton(val);
      }
      return Singleton.instance;
    }
    public getPlatform() {
        console.log(this.paltform)
    }
  }
const xx = {
    arch: "App"
}
let v = Singleton.getInstance(xx);
v.getPlatform()
  