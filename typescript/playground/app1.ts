type BuckState = {}
interface Platform {}
interface ApplePlatform extends Platform {
    archType: string[]
}
interface PlatformConstructor {
    new (state: BuckState): Platform
}
type App = ApplePlatform & PlatformConstructor

function factory<T extends App>(app: T)  {

}