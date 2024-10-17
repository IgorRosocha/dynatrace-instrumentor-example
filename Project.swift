import ProjectDescription

// MARK: - Dynatrace

private let dynatraceAppID: String = {
    "bdec758a-9f38-44cb-a612-26b41e2dee51"
}()

private let dynatraceURL: String = {
    "https://dags.jtfg.com:443/mbeacon/d8393bba-1c4a-4d2d-b99b-288ec20865d3"
}()

private let scheme: Scheme = .scheme(
    name: "dynatrace-example",
    buildAction: .buildAction(
        targets: [
            .target("dynatrace-example")
        ],
        preActions: [
            .executionAction(
                title: "Dynatrace pre-action build",
                scriptText:
                    """
                    export PATH="$PATH:/usr/local/bin"
                    export PATH="$PATH:/opt/homebrew/bin"
                    
                    if [[ -x "$SRCROOT/.dynatrace/DTSwiftInstrumentor" ]]
                    then
                        instrumentorExecutable="$SRCROOT/.dynatrace/DTSwiftInstrumentor"
                        echo "using local Dynatrace SwiftUI instrumentor in: $instrumentorExecutable"
                    elif [[ -x "$(command -v DTSwiftInstrumentor)" ]]
                    then
                        instrumentorExecutable="$(command -v DTSwiftInstrumentor)"
                        echo "using system Dynatrace SwiftUI instrumentor in: $instrumentorExecutable"
                    else
                        echo "error: No installed Dynatrace SwiftUI instrumentor found."
                        exit 1
                    fi
                    
                    "$instrumentorExecutable" instrument "$SRCROOT"
                    exit $?
                    """,
                target: .target("dynatrace-example")
            )
        ]
    )
)

let project = Project(
    name: "dynatrace-example",
    targets: [
        .target(
            name: "dynatrace-example",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.dynatrace-example",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "DTXApplicationID": .string(dynatraceAppID),
                    "DTXBeaconURL": .string(dynatraceURL),
                    "DTXExcludedSwiftUIFiles": .array(["Tuist/"]),
                    "DTXStartupLoadBalancing": true,
                    "DTXUserOptIn": true,
                    "DTXSwiftUIIgnoreDeploymentTarget": true,
                    "DTXUIActionNamePrivacy": true,
                    "DTXSwiftUIInstrumentSimulatorBuilds": true
                ]
            ),
            sources: ["dynatrace-example/Sources/**"],
            resources: ["dynatrace-example/Resources/**"],
            scripts: [
                .dynatraceInstruments()
            ],
            dependencies: [
                .dynatrace,
                .dynatraceSessionReplay
            ]
        ),
        .target(
            name: "dynatrace-exampleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.dynatrace-exampleTests",
            infoPlist: .default,
            sources: ["dynatrace-example/Tests/**"],
            resources: [],
            dependencies: [.target(name: "dynatrace-example")]
        )
    ],
    schemes: [scheme]
)

// MARK: - Dependencies

public extension TargetDependency {
    static let dynatrace = Self.carthage(name: "Dynatrace")
    static let dynatraceSessionReplay = Self.carthage(name: "DynatraceSessionReplay")
}

public extension TargetDependency {
    /// XCFramework dependency built using Carthage
    static func carthage(name: String) -> TargetDependency {
        let name = name.hasSuffix(".xcframework") ? name : name + ".xcframework"
        return .xcframework(path: .relativeToRoot("Carthage/Build/" + name))
    }
}

// MARK: - Scripts

extension TargetScript {
    /// run Dynatrace Instrument script
    static func dynatraceInstruments() -> Self {
        .post(
            path: .relativeToRoot("BuildPhases/Dynatrace.sh"),
            name: "Dynatrace Instrumentation script",
            basedOnDependencyAnalysis: false
        )
    }
}
