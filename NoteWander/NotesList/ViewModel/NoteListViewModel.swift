//
//  NoteListViewModel.swift
//  NoteWander
//
//  Created by Manas Mishra on 28/03/19.
//  Copyright © 2019 manas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol NoteListViewModelDelegate {
    func moveNote(fromIndexPath: IndexPath, toIndexPath: IndexPath)
    func deleteNote(at indexPath: IndexPath)
    func insertNote(at indexPath: IndexPath)
    func updateNote(at indexPath: IndexPath)
    func reloadTable()
}

class NoteListViewModel: NSObject {
    
    var fetchResultController: NSFetchedResultsController<NoteMO>?
    var delegate: NoteListViewModelDelegate?
    let dateFormatter = DateFormatter()
    
    var searchQuerie: String = ""
    
    private var notes: [NoteMO] {
        guard let noteArray = fetchResultController?.fetchedObjects else {return []}
        return noteArray
    }
    
    func getNotes() -> [NoteMO] {
        var newNotes = notes
        if searchQuerie == "" {
            return newNotes
        }
        newNotes = newNotes.filter({ (note) -> Bool in
            return note.noteDescription?.contains(searchQuerie) ?? false
        })
        return newNotes
    }
    
    override init() {
        super.init()
        //initializeFetchResultController()
    }
    
    func getTitle(_ index: Int) -> String {
        let noteTitle = getNotes()[index].title ?? ""
        return noteTitle
    }
    func getDescriptionOfNote(_ index: Int) -> String {
        let noteDesc = getNotes()[index].noteDescription ?? ""
        return noteDesc
    }
    func getUpdatedAt(_ index: Int) -> String {
        guard let updatedDate = getNotes()[index].updatedAt as Date? else {return ""}
        dateFormatter.dateFormat = DateFormatType(rawValue: "yyyy-MM-dd HH:mm:ss")?.rawValue
        return dateFormatter.string(from: updatedDate)
    }
}

extension NoteListViewModel: NSFetchedResultsControllerDelegate {
    func initializeFetchResultController() {
        let fetchRequest: NSFetchRequest<NoteMO> = NoteMO.fetchRequest()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: (appDelegate.persistentContainer.viewContext), sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController?.delegate = self
        do {
            try fetchResultController?.performFetch()
        } catch {
            print(error)
        }
    }
    
    func fetchResultContaining(querie: String) {
        searchQuerie = querie
        delegate?.reloadTable()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.reloadTable()
    }
}


















