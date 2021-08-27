//
//  TodoController.swift
//  Todos
//
//  Created by 乔酱 on 2021/7/26.
//

import UIKit
protocol TodoDelegate {
    func didAdd(name:String)
    func didEdit(name:String)
}

class TodoController: UITableViewController {
    
    
    var delegate:TodoDelegate?
    var name:String?
    
    @IBOutlet weak var todoInput: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoInput.text = name
        
        if name != nil {
            navigationItem.title = "编辑任务"
        }
        
        // 定位光标
        todoInput.becomeFirstResponder()
        
        
    }
    


    @IBAction func done(_ sender: Any) {
        if let name = todoInput.text, !name.isEmpty {
            if self.name != nil {
                delegate?.didEdit(name: name)
            } else {
                delegate?.didAdd(name: name)
            }
        }
        
        // 弹出视图, 当前页面出栈
        navigationController?.popViewController(animated: true)
    }
    


}
