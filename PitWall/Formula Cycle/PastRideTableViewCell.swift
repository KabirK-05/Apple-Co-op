//
//  PastRideTableViewCell.swift
//  PitWall
//
//  Created by Kabir Kumar on 2022-01-18.
//

import UIKit

class PastRideTableViewCell: UITableViewCell {

    @IBOutlet weak var rideView: UIView!
    @IBOutlet weak var rideImage: UIImageView!
    @IBOutlet weak var rideTypeLbl: UILabel!
    @IBOutlet weak var rideColourLbl: UILabel!
    @IBOutlet weak var totalDistLbl: UILabel!
    @IBOutlet weak var avgSpeedLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
