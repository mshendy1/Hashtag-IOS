//
//  CommentsCell.swift
//  HashTag
//
//  Created by Trend-HuB on 24/07/1444 AH.
//

import UIKit

class CommentsCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var imgUser:UIImageView!
    @IBOutlet weak var lblCommentText:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var replayTable:UITableView!
    var commentModel:CommentsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configerCell(model:CommentsModel?){
        commentModel = model
        lblName.text = model?.user?.name ?? ""
        imgUser.contentMode = .scaleAspectFit
        imgUser.clipsToBounds = true
        lblCommentText.text = model?.comment ?? ""
        let day = model?.createAtDayNumber
        let month = model?.createdAtMonth
        lblDate.text = "\(day ?? "") \(month ?? "")"
        
        if model?.replay?.count ?? 0 > 0
        {
            setupTable()
        }
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if let date = inputFormatter.date(from: dateString) {
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format
            print(outputFormatter)
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
}
extension CommentsCell:ReuseIdentifying{}

extension CommentsCell:UITableViewDelegate,UITableViewDataSource {

    func setupTable()
    {
        replayTable.register(UINib(nibName: ReplayCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ReplayCell.reuseIdentifier)
        replayTable.delegate = self
        replayTable.dataSource = self
        replayTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModel?.replay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:ReplayCell.reuseIdentifier) as! ReplayCell
        let index = indexPath.row
        cell.imgUser.loadImage(path:self.commentModel?.replay?[index].user?.photo ?? "")

        cell.configerCell(model: commentModel?.replay?[index])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
