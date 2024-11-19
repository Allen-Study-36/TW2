//
//  ViewController.swift
//  Member_Storyboard
//
//  Created by 김태완 on 11/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memberListManager = MemberListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberListManager.makeMembersListDatas()
        
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberTableViewCell
        
        cell.member = memberListManager.getMembersList()[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            
            // ⭐️스토리보드내 세그웨이 2개 -> 분기처리
            if let _ = sender as? UIBarButtonItem {
                detailVC.member = nil
            } else if let indexPath = sender as? IndexPath {
                detailVC.member = memberListManager.getMembersList()[indexPath.row]
            }
            
            detailVC.delegate = self
        }
    }
    
}

extension ViewController: MemberDelegate {
    
    func addNewMember(_ member: Member) {
        memberListManager.appendMember(member)
        tableView.reloadData()
    }
    
    func update(index: Int, _ member: Member) {
        memberListManager.updateMemberInfo(index: index, member)
        tableView.reloadData()
    }
}
