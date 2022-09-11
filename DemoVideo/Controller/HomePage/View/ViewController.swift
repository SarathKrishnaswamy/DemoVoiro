//
//  ViewController.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import UIKit
import CoreData
import Kingfisher

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var allShows = [ResultDB]()
    var filteredData: [ResultDB]?
    var isSearch = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.filteredData = allShows
        self.searchBar.delegate = self
        if SessionManager.sharedInstance.isDataStored{
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                //self.retrieveData()
               self.getAllShows()
                
            }
        }else{
            self.callApi()
        }
    }
    
    func callApi(){
        let params = [String:Any]()
        APiCall().callAPi(strURL: URL.getPopularMovies, methodType: "GET", postDictionary: params) { bool, response, data  in
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(MoviesModel.self, from: data)
                self.createData(model: model, results: model.results ?? [Results]())
            }
            catch let error as NSError {
                self.presentAlert(withTitle: "Oops", message: error.localizedDescription)
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }

    
    func createData(model:MoviesModel, results:[Results]){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "ResultDB", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
//        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
//        user.setValue(model.page, forKey: "page")
//        user.setValue(model.total_pages, forKey: "total_pages")
//        user.setValue(model.total_results, forKey: "total_results")
        
        
        //let data = model.results ?? []
        
        for item in results {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(item.id, forKey: "id")
            user.setValue(item.adult, forKey: "adult")
            user.setValue(item.original_title, forKey: "original_title")
            user.setValue(item.poster_path, forKey: "poster_path")
            user.setValue(item.title, forKey: "title")
            user.setValue(item.release_date, forKey: "release_date")
            user.setValue(item.poster_path, forKey: "poster_path")
            user.setValue(item.overview, forKey: "overview")
            user.setValue(item.vote_count, forKey: "vote_count")
            user.setValue(item.video, forKey: "video")
            user.setValue(item.vote_average, forKey: "vote_average")
            user.setValue(item.popularity, forKey: "popularity")
            user.setValue(item.backdrop_path, forKey: "backdrop_path")
            user.setValue(item.original_title, forKey: "original_title")
            user.setValue(item.original_language, forKey: "original_language")
            
        }
        
       // print(user)
        SessionManager.sharedInstance.isDataStored = true
        
        

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.getAllShows()
        }
        
        
    }
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext ?? NSManagedObjectContext()
        }
    
    
    func getAllShows() -> Array<ResultDB> {
           let all = NSFetchRequest<ResultDB>(entityName: "ResultDB")
           all.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
          

           do {
               let fetched = try getContext().fetch(all)
              // print(fetched)
               allShows = fetched
               print(allShows)
               self.tableView.reloadData()
               //print(allShows[0].title)
           } catch {
               let nserror = error as NSError
               //TODO: Handle Error
               print(nserror.description)
           }

           return allShows
       }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch{
            return self.filteredData?.count ?? 0
        }
        else{
            return self.allShows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        if isSearch{
            let fullMediaUrl = "https://image.tmdb.org/t/p/original\(filteredData?[indexPath.row].poster_path ?? "")"
            cell.thumbnailImageView.kf.setImage(with:URL.init(string: fullMediaUrl) ?? URL(fileURLWithPath: "") , placeholder: UIImage(named: "dummyProfileImage"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            cell.titleNameLbl.text = filteredData?[indexPath.row].title ?? ""
            cell.dateLbl.text = filteredData?[indexPath.row].release_date ?? ""
        }
        else{
            let fullMediaUrl = "https://image.tmdb.org/t/p/original\(allShows[indexPath.row].poster_path ?? "")"
            cell.thumbnailImageView.kf.setImage(with:URL.init(string: fullMediaUrl) ?? URL(fileURLWithPath: "") , placeholder: UIImage(named: "dummyProfileImage"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            cell.titleNameLbl.text = allShows[indexPath.row].title ?? ""
            cell.dateLbl.text = allShows[indexPath.row].release_date ?? ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        if isSearch{
            vc.thumbImage = filteredData?[indexPath.row].poster_path ?? ""
            vc.releaseDate = filteredData?[indexPath.row].release_date ?? ""
            vc.videoCounts = Int(filteredData?[indexPath.row].vote_count ?? 0)
            vc.overView = filteredData?[indexPath.row].overview ?? ""
            vc.movieTitle = filteredData?[indexPath.row].title ?? ""
        }
        else{
            vc.thumbImage = allShows[indexPath.row].poster_path ?? ""
            vc.releaseDate = allShows[indexPath.row].release_date ?? ""
            vc.videoCounts = Int(allShows[indexPath.row].vote_count ?? 0)
            vc.overView = allShows[indexPath.row].overview ?? ""
            vc.movieTitle = allShows[indexPath.row].title ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.count > 0{
            filteredData = allShows.filter{ $0.title?.range(of: searchText, options: .caseInsensitive) != nil || $0.original_title?.range(of: searchText, options: .caseInsensitive) != nil }
            //filteredData = allShows.filter{ $0.email?.range(of: searchText, options: .caseInsensitive) != nil }
            self.isSearch = true
            self.tableView.reloadData()
        }
        else{
            self.isSearch = false
            self.tableView.reloadData()
        }
        
        
    
    }
}
