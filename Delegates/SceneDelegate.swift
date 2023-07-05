import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene
        else { fatalError("Expected a UIWindowScene.") }

        createWindow(in: windowScene)
        navigationController.visitRootURL()
    }

    // MARK: - Private

    private let navigationController = TurboNavigationController()

    private func createWindow(in windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }
}
