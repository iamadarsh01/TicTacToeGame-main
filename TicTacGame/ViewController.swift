//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Adarsh Bhatia 26/05/22
//




import UIKit

//Defining two enumerations cases Cross and Nought
enum UserTurn{
    case cross, nought
}

class ViewController: UIViewController {
    
    
    
    //Outlets for UI Buttons
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    
    
    //Outlets for UI Labels
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    
    
    //Outlet for winning label
    @IBOutlet weak var lblWinPlayerMessage: UILabel!
    
    
    //IB Action for reseting the game
    @IBAction func restartAction(_ sender: UIButton) {
        
        
    
        resetGame()
        
    }
    
    var firstTurn =   UserTurn.cross
    var currentTurn =  UserTurn.cross
    
    var arrButtons = [UIButton]()
    var lastMove: UIButton?
    
    
    
    //Outlest for showing up  Blur view and Pop up
    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet var popupView: UIView!
    
    
    
    //Actions For showing the pop up
    
    
    @IBAction func showAction(_ sender: Any) {
        animateIn(desiredView: blurView)
        animateIn(desiredView: popupView)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: blurView)
       
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture()
        becomeFirstResponder()
        updateResult()
        
        
        
        
        //For setting the size of the blur view and Pop Up view
        
        blurView.bounds = self.view.bounds
        popupView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.7, height: self.view.bounds.height * 0.5)
        
        
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arrButtons.append(btn1)
        arrButtons.append(btn2)
        arrButtons.append(btn3)
        arrButtons.append(btn4)
        arrButtons.append(btn5)
        arrButtons.append(btn6)
        arrButtons.append(btn7)
        arrButtons.append(btn8)
        arrButtons.append(btn9)
    }
    
    
    //Action: Tap Action
    @IBAction func btnActionTap(_ sender: UIButton) {
        
        if (sender.currentTitle == "" || sender.currentTitle == nil) && lblWinPlayerMessage.text == "" {
            var title = ""
            if currentTurn == .nought{
                title = "X"
                currentTurn = .cross
            }else{
                title = "O"
                currentTurn = .nought
            }
            
            for btn in arrButtons {
                if btn == sender {
                   
                    btn.setTitle(title, for: .normal)
                    btn.setTitleColor(.black, for: .normal)
                   
                }
            }
            
            if checkForResult("X") {
                lblWinPlayerMessage.text = "Player X wins"
                playerXScrore = playerXScrore + 1
                updateResult()
                return
            }
            
            if checkForResult("O") {
                lblWinPlayerMessage.text = "Player O wins"
               playerOScrore = playerOScrore + 1
                updateResult()
                return
            }
            
            if checkForEvenState() {
                lblWinPlayerMessage.text = "It's a Draw!"
                return
            }
            
            lastMove = sender
        }
    }
    
    
    
    //Function for checking if the game is completed or not
   
    func CheckGameOver() -> Bool {
        for btn in arrButtons {
            
            if btn.currentTitle == "" {
                return false
            }
            
        }
        return true
    }
    
    
    
    //Function for reseting the game
    func resetGame() {
        for btn in arrButtons {
            btn.setTitle("", for: .normal)
           
        }
        firstTurn =   UserTurn.cross
        currentTurn =  UserTurn.cross
        lblWinPlayerMessage.text = ""
        
    }
    
    //Function for checking the result
    func checkForResult(_ s: String) -> Bool {
        if checkSymbol(btn1, s) && checkSymbol(btn2, s) && checkSymbol(btn3, s) {
            return  true
        }
        if checkSymbol(btn4, s) && checkSymbol(btn5, s) && checkSymbol(btn6, s) {
            return  true
        }
        if checkSymbol(btn7, s) && checkSymbol(btn8, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        if checkSymbol(btn1, s) && checkSymbol(btn4, s) && checkSymbol(btn7, s) {
            return  true
        }
        if checkSymbol(btn2, s) && checkSymbol(btn5, s) && checkSymbol(btn8, s) {
            return  true
        }
        if checkSymbol(btn3, s) && checkSymbol(btn6, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        
        if checkSymbol(btn1, s) && checkSymbol(btn2, s) && checkSymbol(btn3, s) {
            return  true
        }
        if checkSymbol(btn4, s) && checkSymbol(btn5, s) && checkSymbol(btn6, s) {
            return  true
        }
        if checkSymbol(btn7, s) && checkSymbol(btn8, s) && checkSymbol(btn9, s) {
            return  true
        }
        
        
        if checkSymbol(btn1, s) && checkSymbol(btn5, s) && checkSymbol(btn9, s) {
            return  true
        }
        if checkSymbol(btn3, s) && checkSymbol(btn5   , s) && checkSymbol(btn7, s) {
            return  true
        }
        
        return false
    }
    
    //Function for removing last move made by player
    func undoLastMove() {
        if lastMove?.currentTitle != "" {
            lastMove?.setTitle("", for: .normal)
            currentTurn = currentTurn == .cross ? .nought : .cross
        }
       
    }
    
    
    func checkSymbol(_ btn: UIButton,_ symbol: String) -> Bool {
        return btn.title(for: .normal) == symbol
    }
    
    
    //Function for checking if the game is draw
    func checkForEvenState() -> Bool{
        var count = 0
        for btn in arrButtons {
            
            //if btn.currentTitle.
            if btn.currentTitle?.count ?? 0 > 0 {
                count += 1
            }
        }
        return count == arrButtons.count
    }
    
    
   func alert(message: String) {
        let alert = UIAlertController(title: "Are you sure", message: message, preferredStyle: .alert)
        
        let btnOk = UIAlertAction(title: "Ok", style: .default) { _ in
           self.resetGame()
        }
        alert.addAction(btnOk)
        self.present(alert, animated: true) {
            
        }
    }
    
    //Function for updating the score
    func updateResult() {
        lblPlayerO.text = "\(playerOScrore)"
        lblPlayerX.text = "\(playerXScrore)"
    }
    
}

extension ViewController {
    
    //Declaring a Swipe down gesture
    func addSwipeGesture() {
        
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    //Defining a function which will be called once user will use Swipe down gesture
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let _ = gesture as? UISwipeGestureRecognizer {
            
            
            let alert = UIAlertController(title: "Do You want to Restart ?", message: "", preferredStyle: .alert)
            
            let btnOk = UIAlertAction(title: "Restart", style: .destructive) { _ in
               self.resetGame()
            }
            let btnCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
              
            }
            alert.addAction(btnOk)
            alert.addAction(btnCancel)
            self.present(alert, animated: true) {
                
            }
        }
    }
    
}

extension ViewController {
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
//Calling undoLastMove function once user shaked the device
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            self.undoLastMove()
        }
    }
}

extension ViewController {
    var playerXScrore: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "x")
        }
        get {
            return UserDefaults.standard.value(forKey: "x") as? Int ?? 0
        }
    }
    
    
    
    
    
    
    
    var playerOScrore: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "o")
        }
        get {
            return UserDefaults.standard.value(forKey: "o") as? Int ?? 0
        }
        
        
    }
    
    
    //Function to animate popview
    func animateIn(desiredView : UIView){
        
        let backgroundView = self.view!
        
        backgroundView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        
        UIView.animate(withDuration: 0.3, animations: {
            
            CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
            
        })
        
    }
    
    func animateOut(desiredView : UIView){
        UIView.animate(withDuration: 0.3, animations: {
            
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
            
        }, completion: { _ in
            desiredView.removeFromSuperview()
            
        })
        
    }
    
    
}
