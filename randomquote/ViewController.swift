import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Random Quote", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(quoteLabel)
        view.addSubview(fetchButton)
        
        NSLayoutConstraint.activate([
            quoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fetchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        fetchButton.addTarget(self, action: #selector(fetchQuote), for: .touchUpInside)
    }
    
    // MARK: - Network Request
    @objc private func fetchQuote() {
        guard let url = URL(string: "https://animechan.io/api/v1/quotes/random") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let quoteResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
                let quoteData = quoteResponse.data
                
                DispatchQueue.main.async {
                    self?.quoteLabel.text = """
                    "\(quoteData.content)"
                    
                    - \(quoteData.character.name)
                    Anime Name: \(quoteData.anime.name)
                    """
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
