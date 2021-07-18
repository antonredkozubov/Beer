//
//  TableViewCell.swift
//  Beer
//
//  Created by Anton Redkozubov on 11.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    var model: DataModel?

    func setData(model: DataModel) {
        self.model = model
        textLabel?.text = model.name
        if let url = URL(string: model.imageUrl) {
            self.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"), context: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
