import Foundation

struct Service {
    
    private let network: NetworkProtocol
    var repositories: [Repository]?
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        guard let baseUrl = URL(string: "https://api.github.com/users/\(user)/repos") else { return }
        network.performGet(url: baseUrl) { (data) in
            if let data = data {
                do {
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    completion(repositories)
                } catch {
                    print("Error\(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
