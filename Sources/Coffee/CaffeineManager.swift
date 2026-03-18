import Foundation

@MainActor
final class CaffeineManager: ObservableObject {
    static let shared = CaffeineManager()

    @Published var isActive: Bool = false
    @Published var preventDisplaySleep: Bool = true
    @Published var preventDiskSleep: Bool = false

    private var process: Process?

    private init() {}

    func start() {
        guard process == nil else { return }

        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
        var flags: [String] = ["-i"]
        if preventDisplaySleep { flags.append("-d") }
        if preventDiskSleep    { flags.append("-m") }
        p.arguments = flags + ["-w", String(ProcessInfo.processInfo.processIdentifier)]

        p.terminationHandler = { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.process = nil
                self?.isActive = false
            }
        }

        do {
            try p.run()
            process = p
            isActive = true
        } catch {
            print("Failed to launch caffeinate: \(error)")
        }
    }

    func stop() {
        process?.terminate()
        process = nil
        isActive = false
    }

    /// Blocking shutdown for use in applicationWillTerminate.
    func stopAndWait() {
        guard let p = process else { return }
        p.terminate()
        p.waitUntilExit()
        process = nil
        isActive = false
    }
}
