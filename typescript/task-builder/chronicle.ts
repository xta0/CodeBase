export type DegradedDocumentErrorCode =
    | 'LanguageServerDegradedDocumentError' // unexpected, regrettable
    | 'LanguageServerDegradedDocumentNoAutomodeFile' // automode file not found

export type ChronicleErrorCode = | DegradedDocumentErrorCode
    | 'ActivityError'
    | 'AnnotateDefinitionsError'
    | 'FBTaskRunnerError'

 export type ChronicleActivityName =
    // Please keep this list alphabetized
    | 'CPPAutoCompleteReadiness'
    | 'DebuggerSession'
    | 'ExecuteCommand'
    | 'FindDefinition'
    | 'GlassRemoteCall'
    | 'GoToDeclaration'
    | 'GoToDefinition'
    | 'GoToFile'
    | 'GoToGeneric'
    | 'GoToImplementation'
    | 'GoToReferences'
    | 'GoToTypeDefinition'
    | 'ProvideHover'
    | 'PYLSDocumentReady'
    | 'ReconnectionActivity'
    | 'RemoteConnectionActivity'
    | 'SuggestionAutoComplete';

export type ChronicleEventName =
    | ChronicleActivityName
    // Please keep this list alphabetized
    | '3rdPartyExtensionsSandboxed'
    | 'ActivityDropped'
    | 'ActivityFinished'
    | 'buck build'

export type ChronicleExtras = Record<string, any>;