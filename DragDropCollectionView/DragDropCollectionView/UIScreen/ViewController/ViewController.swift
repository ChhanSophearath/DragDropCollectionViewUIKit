//
//  ViewController.swift
//  DragDropCollectionView
//
//  Created by Rath! on 19/4/24.
//

import UIKit

class ViewController: UIViewController {

    let dragDropView = DragDropView()
    override func loadView() {
        super.loadView()
        view =  dragDropView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
    }


}

