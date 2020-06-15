//
//  TextViewTableViewCell.swift
//  Editor
//
//  Created by GAURAV NAYAK on 15/06/20.
//  Copyright © 2020 CaffeineDevotee. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    var textFormatButtonOutlet = UIBarButtonItem()
    var controller : ViewController?
    
    var formatCase = formatCase_2
    var tuple : (String, Int, Int) = ("", 0, 0)
    
    @IBOutlet weak var editTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(controller : ViewController, tuple : (String, Int, Int)) {
        
        self.controller = controller
        self.editTextView.delegate = self
        self.tuple = tuple
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .white
        var items = [UIBarButtonItem]()
        
        self.textFormatButtonOutlet = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(tapsOnTextFormat))
        self.textFormatButtonOutlet.setBackgroundImage(UIImage(named: "Text_\(self.tuple.1)"), for: .normal, barMetrics: .default)
        self.textFormatButtonOutlet.tintColor = .clear
        self.textFormatButtonOutlet.tag = self.tuple.1
        items.append(self.textFormatButtonOutlet)
        
        toolBar.setItems(items, animated: true)
        toolBar.tintColor = .darkGray
        
        self.editTextView.inputAccessoryView = toolBar
        let attribute = getTextAttribute(type: self.formatCase[self.textFormatButtonOutlet.tag])
        let attributedText = NSAttributedString(string: self.tuple.0, attributes: attribute)
        self.editTextView.attributedText = attributedText
        self.editTextView.typingAttributes = getTextAttribute(type: self.formatCase[self.textFormatButtonOutlet.tag])
        
    }
    
    @objc func tapsOnTextFormat() {
        
        self.textFormatButtonOutlet.tag += 1
        self.textFormatButtonOutlet.tag = self.textFormatButtonOutlet.tag % 3
        self.tuple.1 = self.textFormatButtonOutlet.tag
        self.controller?.tableData[self.tuple.2].1 = self.textFormatButtonOutlet.tag
        let attribute = getTextAttribute(type: self.formatCase[self.textFormatButtonOutlet.tag])
        let attributedText = NSAttributedString(string: self.editTextView.text, attributes: attribute)
        self.editTextView.attributedText = attributedText
        self.editTextView.typingAttributes = attribute
        self.textFormatButtonOutlet.setBackgroundImage(UIImage(named: "Text_\(self.textFormatButtonOutlet.tag)"), for: .normal, barMetrics: .default)
        self.textViewDidChange(self.editTextView)
    }
    
}

extension TextViewTableViewCell : UITextViewDelegate {
    //TextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //Saving the data as you type
        self.controller?.tableData[self.tuple.2].0 = self.editTextView.text
        self.controller?.tableData[self.tuple.2].1 = self.tuple.1
        
        if text == "\n" { //Hit Enter
            self.controller?.tableData.insert(("", 0, self.tuple.2 + 1), at: self.tuple.2 + 1)
            self.controller?.desiredCell = self.tuple.2 + 1
            self.controller?.editTextView.becomeFirstResponder()
            self.controller?.tableView.reloadData()
            
            return false
        } else if text == "" && range.length == 0 && self.tuple.2 != 0 && textView.text.count == 0 { //Empty & Backspace
            self.controller?.tableData.remove(at: self.tuple.2)
            self.controller?.desiredCell = self.tuple.2 - 1
            self.controller?.editTextView.becomeFirstResponder()
            self.controller?.tableView.reloadData()
            
            return false
        } else if text == "" && range.length == 0 && self.tuple.2 != 0 && textView.text.count != 0 { //Not Empty & Backspace
            self.controller?.tableData.remove(at: self.tuple.2)
            self.controller?.desiredCell = self.tuple.2 - 1
            self.controller?.tableData[self.tuple.2 - 1].0.append(" " + textView.text)
            self.controller?.editTextView.becomeFirstResponder()
            self.controller?.tableView.reloadData()
            
            return false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        UIView.setAnimationsEnabled(false)
        textView.sizeToFit()
        self.controller?.tableView.beginUpdates()
        self.controller?.tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
