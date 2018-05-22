//
//  ImageViewController.swift
//  SlideshowApp
//
//  Created by 小島 彬 on 2018/05/22.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: - プロパティ
    var image: String = ""
    
    // MARK: - アウトレット
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - アクション

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
