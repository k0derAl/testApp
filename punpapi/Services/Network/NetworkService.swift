import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func getData(page: Int,
                 perPage: Int,
                 completion: @escaping ([StructJson], Int, Error?) -> Void)

}

class NetworkServiceImp: NetworkServiceProtocol {
    private var manager = SessionManager()

    init() {

    }
    public func getData(page: Int,
                        perPage: Int,
                        completion: @escaping ([StructJson], Int, Error?) -> Void
    ) {
        let data = [
            "page": page,
            "per_page": perPage
        ] as [String: Any]
        let routing = NetRouter.getData(data)
        self.manager.upload(multipartFormData: { _ in

        }, with: routing, encodingCompletion: { [weak self] encodingResult in
            switch encodingResult {
                case .success(let upload, _, _):
                    upload.validate()
                    upload.responseData { responseData in
                        switch responseData.result {
                            case .success:
                                if let data = responseData.data {
                                    do {
                                        let mapping = try JSONDecoder().decode([StructJson].self, from: data)
                                        completion(mapping, page, nil)
                                    } catch {
                                        completion([], page, error)
                                    }
                                }

                            case .failure(let error):
                                    completion([], page, error)
                        }
                    }

                case .failure(let encodingError):
                    completion([], page, encodingError)
            }
        })
    }
}
