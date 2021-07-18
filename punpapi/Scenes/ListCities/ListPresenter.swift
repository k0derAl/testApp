import Foundation
import UIKit
import CoreData

protocol ListViewProtocol {
    func realoadData()
    func startLoad()
    func stopLoad()
    func showError(title: String)
}


protocol ListPresenterProtocol {
    func getItem(index: Int) -> StructJson
    func getCount() -> Int
    func open(index: Int)
    func realoadData()
    func nextData()
}

class ListPresenter {
    var router: ListRouter
    var data = [StructJson]()
    var view: ListViewProtocol
    var page: Int = 0
    let perPage = 5
    
    
    var netowork: NetworkServiceProtocol = DI.resolve()

    init(view: ListViewProtocol, router: ListRouter) {
        self.router = router
        self.view = view
    }
    
    func loadData() {
        self.view.startLoad()
        netowork.getData(page: page, perPage: perPage, completion: { result, page, error in
            self.view.stopLoad()
            if let error = error {
                self.view.showError(title: error.localizedDescription)
                return
            }
            if page == 0 {
                self.data = result
            } else {
                self.data.append(contentsOf: result)
            }
            
            self.view.realoadData()
        })
    }
}

extension ListPresenter: ListPresenterProtocol {
    func realoadData() {
        page = 1
        data.removeAll()
        loadData()
    }
    
    func nextData() {
        page += 1
        loadData()
    }
    
    func getItem(index: Int) -> StructJson {
        return data[index]
    }

    
    func open(index: Int) {
        
    }
    
    func openItem(index: Int) {
        // router.openCity(name: cities[index].name!)
    }

    func getCount() -> Int {
        return data.count
    }
}
