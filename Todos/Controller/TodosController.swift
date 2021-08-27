 //
 //  TodosController.swift
 //  Todos
 //
 //  Created by 乔酱 on 2021/7/25.
 //
 
 import UIKit
 import RealmSwift
 
 class TodosController: UITableViewController {
    
    //    var todos:[Todo] = []
    var todos: Results<Todo>?
    var row = 0
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = self.editButtonItem
        editButtonItem.title = "编辑"
        
        todos = realm.objects(Todo.self)
        
    }
    
    
    // 批量删除数据
    //    @IBAction func batchDelete(_ sender: Any) {
    //        // 删除数据 model
    //        if let indexPaths = tableView.indexPathsForSelectedRows {
    //            for indexPath in indexPaths {
    //                todos.remove(at: indexPath.row)
    //            }
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: indexPaths, with: .automatic)
    //            tableView.endUpdates()
    ////            saveData()
    //        }
    //    }
    //
    // MARK: - Table view data source
    
    // 规定tableview有几段
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 每一段有几行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos?.count ?? 0
    }
    
    // 每行渲染什么再这里渲染
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoCell
        
        
        // Configure the cell...
        if let todos = todos {
            cell.checkMark.text = todos[indexPath.row].checked ? "√":""
            cell.todo.text = todos[indexPath.row].name
        }
        return cell
    }
    
    
    // 当用户选择了cell之后发生了什么事情
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            try realm.write {
                todos![indexPath.row].checked = !todos![indexPath.row].checked
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editButtonItem.title = isEditing ? "完成" : "编辑"
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    // 左划删除cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        do {
            try realm.write {
                realm.delete(todos![indexPath.row])
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
    
    // Override to support rearranging the table view.
//        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//            // 移动数据
//            let fromtodo = todos![fromIndexPath.row]
//            todos!.remove(at: fromIndexPath.row)
//            todos!.insert(fromtodo, at: to.row)
//            // 更新视图
//    //        tableView.moveRow(at: fromIndexPath, to: to)
//            tableView.reloadData()
//    //        saveData(todo: todo)
//        }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //NOTE: sender 用户点击的是哪个cell sender就是哪个cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTodo" {
            let vc = segue.destination as! TodoController
            
            // 告诉我们是谁委托我们干活的-本控制器的老板是谁
            vc.delegate = self
            
        } else if segue.identifier == "editTodo" {
            let vc = segue.destination as! TodoController
            let cell = sender as! TodoCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = todos![row].name
            vc.delegate = self
        }
        
    }
    
    
 }
 
 
 extension TodosController:TodoDelegate,UISearchBarDelegate {
    func didAdd(name: String) {
        // model 添加数据
        let todo = Todo()
        todo.name = name
        todo.checked = false
        //        todos.append(todo)
        saveData(todo:todo)
        // view 更新视图
        tableView.reloadData()
        //        let indexPath = IndexPath(row: todos.count - 1, section: 0)
        //        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func didEdit(name: String) {
        //        todos?[row].name = name
        //        UserDefaults.standard.set(todos,forKey: "todos")
        //        let indexPath = IndexPath(row: row, section: 0)
        //        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        //        cell.todo.text = name
        do{
            try realm.write {
                todos![row].name = name
            }
        } catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    
    func saveData(todo:Todo) {
        do{
            try realm.write {
                realm.add(todo)
            }
        }catch{
            print(error)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 查数据
        todos = realm.objects(Todo.self).filter("name CONTAINS %@",searchBar.text!)
        // 更新view
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            todos = realm.objects(Todo.self)
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
    }
 }
