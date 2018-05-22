//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 小島 彬 on 2018/05/20.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit

let imageArray: [String] = [
    "cat_01.jpg",
    "cat_02.jpg",
    "cat_03.jpg",
    "cat_04.jpg",
    "cat_05.jpg",
    "cat_06.jpg"
]

class ViewController: UIViewController {

    // MARK: - プロパティ
    // 表示している画像の番号
    var displayNumber: Int = 0
    
    // 再生/停止ボタン
    var isPlay: Bool = true
    
    // タイマー用の時間のための変数
    var timer: Timer!
    var timer_sec: Float = 0
    
    // MARK: - アウトレット
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // タップの設定
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onImageTap)
        )
        imageView.addGestureRecognizer(tapGesture)
        
        // 右スワイプの設定
        let rightSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(didRightSwipe)
        )
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        // 左スワイプの設定
        let leftSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(didLeftSwipe)
        )
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)

        // 画像の表示
        self.displayImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        {
        case "ShowImageViewController":
            let viewController:ImageViewController = segue.destination as! ImageViewController
            viewController.image = imageArray[displayNumber]
            break
        default:
            break
        }
    }
    
    // MARK: - アクション
    /// 画像をタップ
    ///
    /// - Parameter sender: <#sender description#>
    @objc
    func onImageTap(recognizer: UITapGestureRecognizer)
    {
        print("画像をタップ")
        self.stopProc()
        self.isPlay = true
        self.playStopButton.setTitle("再生", for: UIControlState.normal)
        self.performSegue(withIdentifier: "ShowImageViewController", sender: nil)
    }
    
    /// 画像を左スワイプ
    ///
    /// - Parameter recognizer: <#recognizer description#>
    @objc
    func didLeftSwipe(recognizer: UISwipeGestureRecognizer)
    {
        print("画像を左スワイプ")
        if (self.isPlay)
        {
            self.changeImage(change: -1)
        }
    }
    
    /// 画像を右スワイプ
    ///
    /// - Parameter recognizer: <#recognizer description#>
    @objc
    func didRightSwipe(recognizer: UISwipeGestureRecognizer)
    {
        print("画像を右スワイプ")
        if (self.isPlay)
        {
            self.changeImage(change: 1)
        }
    }
    
    /// 再生/停止ボタン押下
    ///
    /// - Parameter sender: 再生/停止ボタン
    @IBAction func onPlayStop(_ sender: UIButton)
    {
        //　プロパティによる処理
        if (self.isPlay)
        {   // 再生
            self.startProc()
        }
        else
        {   // 停止
            self.stopProc()
        }
        
        // プロパティの反転
        if (self.isPlay)
        {
            self.isPlay = false
            self.playStopButton.setTitle("停止", for: UIControlState.normal)
        }
        else
        {
            self.isPlay = true
            self.playStopButton.setTitle("再生", for: UIControlState.normal)
        }
    }
    
    /// 戻るボタン押下
    ///
    /// - Parameter sender: 戻るボタン
    @IBAction func onPrev(_ sender: UIButton)
    {
        print("戻るボタン押下")
        self.changeImage(change: -1)
    }
    
    /// 進むボタン押下
    ///
    /// - Parameter sender: 進むボタン
    @IBAction func onNext(_ sender: UIButton)
    {
        print("進むボタン押下")
        self.changeImage(change: 1)
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        
    }
    
    // MARK: - privateMethod
    
    /// 画像の変更
    ///
    /// - Parameter change: 変化量
    func changeImage(change: Int)
    {
        let min: Int = 0
        let max: Int = imageArray.count - 1
        
        if (change >= 0)
        {   // プラス
            // 画像の変更
            if (displayNumber == max)
            {
                displayNumber = min
            }
            else
            {
                displayNumber = displayNumber + 1
            }
        }
        else
        {   // マイナス
            // 画像の番号を変更
            if (displayNumber <= min)
            {
                displayNumber = max
            }
            else
            {
                displayNumber = displayNumber - 1
            }
        }
        
        // 画像の表示
        self.displayImage()
    }
    
    /// 画像の表示
    func displayImage()
    {
        let name: String = imageArray[displayNumber]
        self.imageView.image = UIImage(named: name)
    }
    
    // selector: #selector(updatetimer) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc
    func updateTimer(timer: Timer)
    {
        self.timer_sec += 2.0
        self.changeImage(change: 1)
    }
    
    /// 再生処理
    func startProc()
    {
        // 戻る・進むボタン押下不可
        self.prevButton.isEnabled = false
        self.nextButton.isEnabled = false
        
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    /// 停止処理
    func stopProc()
    {
        // 戻る・進むボタン押下可能
        self.prevButton.isEnabled = true
        self.nextButton.isEnabled = true
        
        if self.timer != nil {
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
        }
    }
    
    // MARK: -
}

