import SwiftUI

struct ContentView: View {
    @ObservedObject var manager: CaffeineManager

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: manager.isActive ? "cup.and.heat.waves.fill" : "cup.and.heat.waves")
                .font(.system(size: 40))
                .foregroundStyle(manager.isActive ? .brown : .secondary)

            Text(manager.isActive ? "Caffeinated" : "Sleeping allowed")
                .font(.headline)

            Button(manager.isActive ? "Deactivate" : "Activate") {
                if manager.isActive {
                    manager.stop()
                } else {
                    manager.start()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(manager.isActive ? .gray : .brown)

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("When caffeinated:")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Toggle("Allow screen sleep", isOn: Binding(
                    get: { !manager.preventDisplaySleep },
                    set: { manager.preventDisplaySleep = !$0 }
                ))
                .disabled(manager.isActive)
                Toggle("Allow disk sleep", isOn: Binding(
                    get: { !manager.preventDiskSleep },
                    set: { manager.preventDiskSleep = !$0 }
                ))
                .disabled(manager.isActive)
            }
            .font(.caption)

            Divider()

            Button("Quit Coffee") {
                NSApplication.shared.terminate(nil)
            }
            .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(width: 220)
    }
}
