import UIKit
import CoreData
class ListVC: UITableViewController {
    
    var presenter: ListPresenterProtocol?
    var textField = UITextField()
    override func viewDidLoad() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: R.string.locale.loading())
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        super.viewDidLoad()
        if presenter == nil {
            ListConfigurator().configure(view: self)
        }
        presenter?.realoadData()
    }
    
    @objc func refresh(sender: AnyObject) {
        refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getCount()) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = presenter!.getItem(index: indexPath.row)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellId")
        cell.imageView?.backgroundColor = .black
        cell.textLabel!.text = item.name
        cell.imageView!.setImageKF(item.image_url)
        if let count = presenter?.getCount() {
            if count > 0 && (count - 1) == indexPath.row {
                presenter?.nextData()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // presenter?.openCity(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

extension ListVC: ListViewProtocol {
    func showError(title: String) {
        
    }
    
    func realoadData() {
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func startLoad() {
        refreshControl?.beginRefreshing()
    }
    
    func stopLoad() {
        refreshControl?.endRefreshing()
    }
    
}
