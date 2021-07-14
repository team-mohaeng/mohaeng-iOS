//
//  EmptyChallengeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class EmptyChallengeViewController: UIViewController {
    
    // MARK: - @IBOutlet Proeperties
    
    @IBOutlet weak var selectButton: UIButton!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
    private func initViewRounding() {
        selectButton.makeRounded(radius: selectButton.frame.height / 2)
    }
    
    private func pushToCourseLibraryViewController() {
        let courseLibraryStoryabord = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
        guard let courseLibarayViewController = courseLibraryStoryabord.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else { return }
        
        courseLibarayViewController.doingCourse = false
        
        self.navigationController?.pushViewController(courseLibarayViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToCourseLibraryViewController()
    }
    
}
