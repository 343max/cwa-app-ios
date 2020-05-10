//
//  ConfirmationViewController.swift
//  ENA
//
//  Created by Zildzic, Adnan on 30.04.20.
//  Copyright © 2020 SAP SE. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = AppStrings.ExposureSubmissionConfirmation.title
        descriptionLabel.text = AppStrings.ExposureSubmissionConfirmation.description
        submitButton.setTitle(AppStrings.ExposureSubmissionConfirmation.submit, for: .normal)
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
