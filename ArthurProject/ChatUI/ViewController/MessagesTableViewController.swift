import UIKit

class MessagesTableViewController: UITableViewController {
    private var messages = [MessageData]()  {
        didSet {
            tableView.reloadData()
        }
    }
    private var viewModel: MessageViewModel
    
    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)

        self.viewModel.messagesData.bindTo { [weak self] messages in
            guard let self = self else { return }
            self.messages = messages
        }
    }
    
    //shall never be used in code only vc
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages"
        
        configureTableView()
        viewModel.fetchMessage()
    }
    
    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.register(
            RightMessageBubbleTableViewCell.self,
            forCellReuseIdentifier: MessageBubbleCellType.rightText.rawValue)
        tableView.register(
            LeftMessageBubbleTableViewCell.self,
            forCellReuseIdentifier: MessageBubbleCellType.leftText.rawValue)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        var cell: MessageBubbleTableViewCell
        if message.sentByMe {
            cell = tableView.dequeueReusableCell(
                withIdentifier: MessageBubbleCellType.rightText.rawValue,
                for: indexPath) as! RightMessageBubbleTableViewCell
        }
        else {
            cell = tableView.dequeueReusableCell(
                withIdentifier: MessageBubbleCellType.leftText.rawValue,
                for: indexPath) as! LeftMessageBubbleTableViewCell
        }
        
        cell.configCellWith(message: message)
        
        return cell
    }
}
