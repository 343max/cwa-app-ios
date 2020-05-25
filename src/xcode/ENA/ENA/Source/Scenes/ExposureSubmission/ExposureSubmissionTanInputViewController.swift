//
//  ExposureSubmissionTanInputViewController.swift
//  ENA
//
//  Created by Marc-Peter Eisinger on 19.05.20.
//  Copyright © 2020 SAP SE. All rights reserved.
//

import Foundation
import UIKit


class ExposureSubmissionTanInputViewController: UIViewController {
	@IBOutlet weak var tanInput: ENATanInput!
	
	
	var initialTan: String?
    var exposureSubmissionService: ExposureSubmissionService?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let tan = initialTan {
			tanInput.clear()
			tanInput.insertText(tan)
			initialTan = nil
		} else {
			tanInput.becomeFirstResponder()
		}
	}
}


extension ExposureSubmissionTanInputViewController {
	enum Segue: String, SegueIdentifiers {
		case sentSegue = "sentSegue"
	}
}


extension ExposureSubmissionTanInputViewController: ExposureSubmissionNavigationControllerChild {
	func didTapBottomButton() {
        
        // Ask user whether generating TAN is fine.
        showAlertController(with: .teleTan(self.tanInput.text))

	}
    
    // TODO: Can be refactored by moving to a space
    // where both Tan and QR Code can access this code.
    private func showAlertController(with type: SubmissionAuthorizationType) {
        let alert = UIAlertController(title: AppStrings.Common.alertTitleKeySubmit,
                                      message: AppStrings.Common.alertDescriptionKeySubmit,
                                      preferredStyle: .alert)
        
        alert
            .addAction(
                UIAlertAction(title: AppStrings.Common.alertActionOk,
                              style: .default,
                              handler: { _ in
                                self.exposureSubmissionService?
                                    .submitExposure(with: type,
                                                    completionHandler: { error in
                                                        // TODO: Handle case in which exposure
                                                        // submission failed.
                                                        if error == nil {
                                                            self.performSegue(withIdentifier: Segue.sentSegue, sender: nil)
                                                            alert.dismiss(animated: true, completion: nil)
                                                            return
                                                        }
                                        })
                                        
        }))
        
        alert.addAction(UIAlertAction(title: AppStrings.Common.alertActionNo,
                                      style: .cancel,
                                      handler: { _ in
                                        alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
