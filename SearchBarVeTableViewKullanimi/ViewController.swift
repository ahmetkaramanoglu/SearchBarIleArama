//
//  ViewController.swift
//  SearchBarVeTableViewKullanimi
//
//  Created by Ahmet Karamanoğlu on 14.12.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var ulkeler = [String]()
    var aramaSonucuUlkeler = [String]()
    
    var aramaYapiliyorMu = false //arama yapilip yapilmadigini ogrenicez.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ulkeler = ["Turkiye","Almanya","Fransa","Japonya","Rusya","Italya","Misir","Filistin"]
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if aramaYapiliyorMu {
            return aramaSonucuUlkeler.count
        }
        else {
            return ulkeler.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ulkelerHucre", for: indexPath)
        
        if aramaYapiliyorMu {
            cell.textLabel?.text = aramaSonucuUlkeler[indexPath.row]
        }
        else {
            cell.textLabel?.text = ulkeler[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if aramaYapiliyorMu {
            print("Secilen Ulke: \(aramaSonucuUlkeler[indexPath.row])")
        }
        else {
            print("Secilen Ulke: \(ulkeler[indexPath.row])")
        }
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu: \(searchText)")
        
        //burda arama yapilacak ve arama sonucunu aktarmamiz gerekiyor.
        
        if searchText == "" {
            aramaYapiliyorMu = false
        }
        else {
            aramaYapiliyorMu = true
            aramaSonucuUlkeler = ulkeler.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        
        
        //hala aktarma yapmadik.
        tableView.reloadData() // arama sonucu olur ama yeni veriyi yukleyemezsin. bu her seferinde calistiginda yukaridaki 4 tane method tekrardan calisir (cellrowat vs.).
        
    }
    
    
}
