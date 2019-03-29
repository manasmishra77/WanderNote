//
//  NoteWanderNavigationBar.swift
//  NoteWander
//
//  Created by Manas Mishra on 28/03/19.
//  Copyright © 2019 manas. All rights reserved.
//

import UIKit

protocol DelegateToNoteWanderList: AnyObject {
    func addNewNote()
    func searchCancelButtonTapped()
    func seachTextDidChange(_ searchText: String)
}

class NoteWanderNavigationBar: UIView {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var containerViewForIcons: UIView!
    
    @IBOutlet weak var noteTitle: UILabel!
    
    weak var delegateToNoteListVC: DelegateToNoteWanderList?
    
    class func intantiate(superview: UIView, delegate: DelegateToNoteWanderList, height: CGFloat) -> NoteWanderNavigationBar? {
        guard let noteWanderNavigationBar = Bundle.main.loadNibNamed("NoteWanderNavigationBar", owner: self, options: nil)?.first as? NoteWanderNavigationBar else {return nil}
        noteWanderNavigationBar.addAsSubviewWithFourConstraintsWithConstantHeight(superview, height: height)
        noteWanderNavigationBar.delegateToNoteListVC = delegate
        noteWanderNavigationBar.toggleSearchBar(shouldHide: true)
        noteWanderNavigationBar.searchBar.delegate = noteWanderNavigationBar
        return noteWanderNavigationBar
    }
    
    func toggleSearchBar(shouldHide: Bool) {
        self.searchBar.isHidden = shouldHide
        self.containerViewForIcons.isUserInteractionEnabled = shouldHide
        if shouldHide {
            self.endEditing(true)
        }
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        delegateToNoteListVC?.addNewNote()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        toggleSearchBar(shouldHide: false)
    }
}

extension NoteWanderNavigationBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegateToNoteListVC?.seachTextDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        toggleSearchBar(shouldHide: true)
        delegateToNoteListVC?.searchCancelButtonTapped()
    }
}
 
