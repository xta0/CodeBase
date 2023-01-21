namespace NAME{
    type BuckState = {
        version: string
    }

    type RunContext = {
        buckState: BuckState
    }

    interface Platform {
        supportedActions?(context: RunContext): void
        buckMode?(context: RunContext): string[]
        prepare(context: RunContext): Promise<void>
        launch(context: RunContext): Promise<void>
        postprocess(context: RunContext): Promise<void>
    }

    interface PlatformConsturctor {
        new (state: BuckState): Platform
    }

    type AppleArch =
        | 'ios-sim'
        | 'ios-device'
        | 'macos'

    interface ApplePlatform extends Platform {
        archType(): AppleArch;
    }

    class IOSPlatform<T extends ApplePlatform> implements Platform {
        constructor(private platform: T){}
        prepare(context: RunContext): Promise<void> {
            return this.platform.prepare(context)
        }
        launch(context: RunContext): Promise<void> {
            return this.platform.launch(context);
        }
        postprocess(context: RunContext): Promise<void> {
            return this.platform.postprocess(context)
        }
    }

    class IPhoneSimulatorPlatform implements Partial<ApplePlatform> {
        constructor(readonly buckState: BuckState) {}
        archType(): AppleArch {
            return 'ios-sim'
        }
        prepare(context: RunContext): Promise<void> {
            console.log(`${this.archType().toString()} : prepare`)
            return Promise.resolve(void 0);
        }
        launch(context: RunContext): Promise<void> {
            return Promise.resolve(void 0);
        }
        postprocess(context: RunContext): Promise<void> {
            return Promise.resolve(void 0);
        }
    }

    class IPhoneDevicePlatform implements ApplePlatform {
        constructor(readonly buckState: BuckState) {}
        archType(): AppleArch {
            return 'ios-device'
        }
        supportedActions(context: RunContext): void {
            
        }
        buckMode(context: RunContext): string[] {
            return []
        }
        prepare(context: RunContext): Promise<void> {
            console.log(`${this.archType().toString()} : prepare`)
            return Promise.resolve(void 0);
        }
        launch(context: RunContext): Promise<void> {
            return Promise.resolve(void 0);
        }
        postprocess(context: RunContext): Promise<void> {
            return Promise.resolve(void 0);
        }
    }

    type X = PlatformConsturctor & ApplePlatform


    function ApplePlatfromFactory<T extends X>(platformName: T , state:BuckState): Platform {
        const platformImpl = new platformName(state)
        return new IOSPlatform(platformImpl as ApplePlatform)
    }
    const buckState = {
        version: "buck1"
    }
    const context = {
        buckState: buckState
    }
    const iOSPlatfrom = ApplePlatfromFactory(IPhoneSimulatorPlatform, buckState)
    iOSPlatfrom.prepare(context)


    const PLATFORM_CLASS: { [key: string]: PlatformConsturctor } = {
        'bundle_ios-sim': IPhoneSimulatorPlatform, 
        'bundle_ios-device': IPhoneDevicePlatform
    }