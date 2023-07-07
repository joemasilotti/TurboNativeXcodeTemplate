/**

 ## Don't forget to add the `Turbo` dependency:

 1. Click File → Add Packages…
 2. In the search box in the upper right, enter:
    https://github.com/hotwired/turbo-ios
 3. Click Add Package
 4. Click Add Package, again

 */

import Turbo
import UIKit
import WebKit

let rootURL = URL(string: "http://localhost:3000")!

class TurboNavigationController: UINavigationController {
    func visitRootURL() {
        let visitable = VisitableViewController(url: rootURL)
        pushViewController(visitable, animated: true)
        session.visit(visitable)
    }

    // MARK: Private

    private lazy var session: Session = {
        let configuration = WKWebViewConfiguration()
        // Identifies Turbo Native apps with `turbo_native_app?` helper in Rails.
        configuration.applicationNameForUserAgent = "Turbo Native iOS"

        let session = Session(webViewConfiguration: configuration)
        session.delegate = self
        return session
    }()
}

// MARK: SessionDelegate

extension TurboNavigationController: SessionDelegate {
    func session(_ session: Session, didProposeVisit proposal: VisitProposal) {
        let controller = VisitableViewController(url: proposal.url)
        session.visit(controller, options: proposal.options)
        pushViewController(controller, animated: true)
    }

    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, error: Error) {
        print("Error visiting page: \(error.localizedDescription)")
    }

    func sessionWebViewProcessDidTerminate(_ session: Session) {
        fatalError("Web view process terminated")
    }
}
