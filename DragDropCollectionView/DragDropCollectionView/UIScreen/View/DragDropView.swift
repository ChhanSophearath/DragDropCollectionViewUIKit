//
//  DragDropView.swift
//  DragDropCollectionView
//
//  Created by Rath! on 19/4/24.
//

import UIKit


let widthScreen = UIScreen.main.bounds.width

class DragDropView: UIView {
    
    var  dataList : [TitleImageModel] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .white
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(MenuListCell.self, forCellWithReuseIdentifier: MenuListCell.identifier )
            
//            collectionView.dragDelegate = self
//            collectionView.dropDelegate = self
            collectionView.dragInteractionEnabled = true
            
            
            return collectionView
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUIView(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
    }
    

}

//MAR: DataSource Delegate
extension DragDropView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuListCell.identifier, for: indexPath) as! MenuListCell
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          // Adjust item size as per your requirements
          
          let width: CGFloat =   widthScreen/3
          
          return CGSize(width: width, height: width)
      }
    
}

//extension DragDropView: UICollectionViewDragDelegate, UICollectionViewDropDelegate{
//    
//    
//    // MARK: - UICollectionViewDragDelegate
//    
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        
//        let generator = UIImpactFeedbackGenerator(style: .light) // You can change the style to .medium or .heavy
//        generator.prepare()
//        generator.impactOccurred()
//        
//        let titleImageModel = dataList[indexPath.item]
//        let itemProvider = NSItemProvider(object: titleImageModel.title as NSString)
//        let dragItem = UIDragItem(itemProvider: itemProvider)
//        dragItem.localObject = collectionView.cellForItem(at: indexPath)
//        return [dragItem]
//    }
//    
//    // MARK: - UICollectionViewDropDelegate
//    
//    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: NSString.self)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
//        let isLocalDrag = session.localDragSession != nil
//        return UICollectionViewDropProposal(operation: isLocalDrag ? .move : .copy, intent: .insertAtDestinationIndexPath)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        let destinationIndexPath: IndexPath
//        
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            let section = collectionView.numberOfSections - 1
//            let row = collectionView.numberOfItems(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//        
//        for item in coordinator.items {
//            if let sourceIndexPath = item.sourceIndexPath {
//                if let _ = item.dragItem.localObject as? MenuListCell {
//                    collectionView.performBatchUpdates({
//                        
//                        
//                        if sourceIndexPath.item < dataList.count {
//                            let movedItem = dataList.remove(at: sourceIndexPath.item)
//                            // Perform any additional operations with the movedItem
//                            dataList.insert(movedItem, at: destinationIndexPath.item)
//                        }
//                        
//                        collectionView.deleteItems(at: [sourceIndexPath])
//                        collectionView.insertItems(at: [destinationIndexPath])
//                    }, completion: { finished in
//                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
//                    })
//                }
//            } else {
//                let placeholderContext = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "CellIdentifier"))
//                
//                item.dragItem.itemProvider.loadObject(ofClass: NSString.self, completionHandler: { (object, error) in
//                    if let draggedItem = object as? NSString {
//                        DispatchQueue.main.async {
//                            placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
//                                let titleImageModel = TitleImageModel(image: UIImage(systemName: "") ?? UIImage(),
//                                                                      title: draggedItem as String)
//                                self.dataList.insert(titleImageModel, at: insertionIndexPath.item)
//                                collectionView.insertItems(at: [insertionIndexPath])
//                            })
//                        }
//                    }
//                })
//            }
//        }
//        
//        let generator = UIImpactFeedbackGenerator(style: .light) // You can change the style to .medium or .heavy
//        generator.prepare()
//        generator.impactOccurred()
//    }
//}





class MenuListCell: UICollectionViewCell {
    
    static let identifier = "MenuListCell"
    
    var nsWidth = NSLayoutConstraint()
    var nsHeight = NSLayoutConstraint()
    
    var sizeImage:CGFloat = 64{
        didSet{

            nsHeight.isActive = false
            nsWidth.isActive = false
            nsHeight = imgIcone.heightAnchor.constraint(equalToConstant: sizeImage)
            nsWidth =   imgIcone.widthAnchor.constraint(equalToConstant: sizeImage)
            nsHeight.isActive = true
            nsWidth.isActive = true
        }
    }
    
    
    let imgIcone: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
//        label.fontLight(14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        backgroundColor = .clear
        layer.cornerRadius = 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    private func setupViews() {
        // Add and configure subviews
        contentView.addSubview(imgIcone)
        contentView.addSubview(titleLabel)
        
        // Configure constraints
        imgIcone.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        nsHeight = imgIcone.heightAnchor.constraint(equalToConstant: sizeImage)
        nsWidth =   imgIcone.widthAnchor.constraint(equalToConstant: sizeImage)
        
        nsHeight.isActive = true
        nsWidth.isActive = true
        
        NSLayoutConstraint.activate([


            imgIcone.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgIcone.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -8),
            

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
    }
}
