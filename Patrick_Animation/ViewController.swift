//
//  ViewController.swift
//  Patrick_Animation
//
//  Created by pratik panchal on 23/01/18.
//  Copyright © 2018 com.Panamax.PushTestApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- outlets & Variables
    @IBOutlet weak var tblviewUser: UITableView!
    
    var arryHeaderName = ["Smart Police Station","Traffic Service","Prevent Crime","Genral Service"]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadExpandableCellXIB()
        tblviewUser.estimatedRowHeight = 80
        tblviewUser.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


//MARK:- Tableview DataSource & Delegate
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
  
    // Load Xib
    func loadExpandableCellXIB()
    {
        tblviewUser.register(UINib(nibName: "cellHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "cellHeader")
        
    }
    
    //MARK:- UITableview DataSource and Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
//                return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tblviewUser.dequeueReusableHeaderFooterView(withIdentifier: "cellHeader") as! cellHeader
        
        headerView.lblTitle.text = arryHeaderName[section]
        headerView.lblTitle.textColor = UIColor.white
        return headerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arryHeaderName.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:cellUser = tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath) as! cellUser
        
        cell.lblName.text = ""
        
        
        // For Dynamic Height of Collection View inside Tableview
        // deque a cell
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionViewUser.reloadData()
        cell.collectionViewHeight.constant = cell.collectionViewUser.collectionViewLayout.collectionViewContentSize.height;
        
        return cell
    }
    
    
    func setGradientBackground(_ colorTops : UIColor ,colorBottoms : UIColor) {
        let colorTop =  colorTops.cgColor
        let colorBottom = colorBottoms.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        if self.view.layer.sublayers!.count > 1{
            
            UIView.animate(withDuration: 0.5) {
                
                self.view.layer.sublayers!.remove(at: 0)
                self.view.layer.insertSublayer(gradientLayer, at: 0)
                self.view.layoutIfNeeded()
            }
            

        }else{
            
            UIView.animate(withDuration: 0.5) {                
                self.view.layer.insertSublayer(gradientLayer, at: 0)
                self.view.layoutIfNeeded()
            }

        }
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        
//        UIView.animate(withDuration: 0.5) {
//            self.view.backgroundColor = self.generateRandomColor()
//            self.view.layoutIfNeeded()
//        }
//    }

        switch section {
        case 0:
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
                self.setGradientBackground(UIColor.cyan, colorBottoms: UIColor.green)
                
            })
            break
        case 1:
            UIView.animate(withDuration: 1.5, delay: 1.0, options: .curveEaseOut, animations: {() -> Void in
                self.setGradientBackground(UIColor.cyan, colorBottoms: UIColor.blue)

            })
            break
        case 2:
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
                self.setGradientBackground(UIColor.cyan, colorBottoms: UIColor.yellow)
            })
            break
        case 3:
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn, .curveEaseOut, .allowUserInteraction], animations: {() -> Void in
                self.setGradientBackground(UIColor.cyan, colorBottoms: UIColor.magenta)
            })
            break
        case 4:
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn, .curveEaseOut, .allowUserInteraction], animations: {() -> Void in
                self.setGradientBackground(UIColor.cyan, colorBottoms: UIColor.orange)
            })
            break
        default:
            self.view.backgroundColor = UIColor.brown
            break
        }
    }
 
}



//MARK: - Cell tableview
class cellUser :UITableViewCell{
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionViewUser: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
}


//MARK:- Collectionview Datasource & Delegate
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell :cellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! cellCollection
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let nbCol = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
        
    }

}


