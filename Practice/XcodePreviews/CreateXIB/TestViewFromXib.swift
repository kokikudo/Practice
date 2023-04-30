import UIKit

class TestViewFromXib: UIView, InputAppliable {
    func apply(input: Input) {
        switch input {
        case .setItems(let items):
            updateViews(items)
        }
    }
    
    enum Input {
        case setItems(items: [String])
    }
    
    //@IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private var items = ["koki", "nathumi", "kazuhiro"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func updateViews(_ items: [String]) {
        self.items = items
        collectionView.reloadData()
    }
    
    private func setupCollentionView() {
        flowLayout.estimatedItemSize = CGSize(width: 50, height: 20)
        
        collectionView.register(UINib(nibName: TestViewFromXibCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: TestViewFromXibCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setup() {
        let view = Bundle.main.loadNibNamed(self.className, owner: self)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        
        setupCollentionView()
    }
}

extension TestViewFromXib: UICollectionViewDelegate {
    
}

extension TestViewFromXib: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestViewFromXibCollectionViewCell.className, for: indexPath) as? TestViewFromXibCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(text: items[indexPath.row])
        
        return cell
    }
    
    
}
