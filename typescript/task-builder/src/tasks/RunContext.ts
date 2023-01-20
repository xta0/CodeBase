export type RunContext = {
    runID: string;
    shouldDebug: boolean;
    skipInstall: boolean;
    logInfo: (message: string) => void;
    logError: (message: string) => void;
    // Fields set directly by fb-remote-launcher steps:
    toolchainPath?: string | null;
    buckBuildID?: string;
    prefetchEnabled?: boolean;
    zstdCompressionLevel?: number;
    bundleSize?: number;
    bundleDownloadHandle?: string;
    launchedAppPid?: string;
    launchedAppId?: string;
    lldbAttachCommands?: Array<string>;
  };