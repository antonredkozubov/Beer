//
//  IngredientViewCell.swift
//  Beer
//
//  Created by Anton Redkozubov on 17.07.2021.
//

import UIKit

class IngredientViewCell: UITableViewCell {

    var model: IngredientItem?

    func setData(model: IngredientItem) {
        self.model = model
        textLabel?.text = model.name + " - " + "\(model.amount.value)" + " " + model.amount.unit
        textLabel?.numberOfLines = 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
