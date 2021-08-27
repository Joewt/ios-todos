//
//  TodoCell.swift
//  Todos
//
//  Created by 乔酱 on 2021/7/26.
//

import UIKit

class TodoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var checkMark: UILabel!
    @IBOutlet weak var todo: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
