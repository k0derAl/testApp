import Foundation
import UIKit

class ListConfigurator {
    func configure(view: ListVC) {
        let router = ListRouter(view)
        let presenter = ListPresenter(view: view, router: router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = ListVC()
        // let view = ChatViewController(titleChat: titleChat)
        ListConfigurator().configure(

            view: view)

        navigationController.navigationItem.hidesBackButton = false
        navigationController.pushViewController(view, animated: true)
    }
}
