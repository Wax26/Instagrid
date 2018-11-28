//
//  CLLocationManager.swift
//  Instagrid
//
//  Created by Walim on 20/07/2018.
//  Copyright © 2018 Walim Aloui. All rights reserved.
//

import CoreLocation

extension ViewController : CLLocationManagerDelegate {
    
    // MARK: - LOCATION MANAGEMENT
    
    /* NOTE : When app is running, pushing a lot on the location button may cause the UITextField get filled with the "Sorry, Something wrong occured etc." message.
        please consult this link https://stackoverflow.com/questions/17867422/kclerrordomain-error-2-after-geocoding-repeatedly-with-clgeocoder
        Apparently, this not due to code, but to the the network. The correct result appears in UITextField withing a fue seconds.
    */
    
    // Info accuracy and details that location asks for
    func displayLocationInfo(_ placemark : CLPlacemark?) {
        if let containsPlacemark = placemark {
            locationManager.startUpdatingLocation()
            let locality = (containsPlacemark.location != nil) ? containsPlacemark.locality : ""
           // let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil ) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            self.locationTextField.text = " " + locality!
            self.locationTextField.text?.append("\n" + administrativeArea! + ", " + country!)
            // stop update location to avoi textField to be overwritten
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Function that actually gets the location
    func locationManager(_ manager : CLLocationManager, didUpdateLocations locations : [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) -> Void in
            if (error != nil) {
                self.locationTextField.text = "Sorry, something wrong occured..." + error!.localizedDescription
                print(error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            } else {
                self.locationTextField.text = "Problem with the data received from geocoder"
            }
        }
    }
    
    // What happens when location fails or is disabled
    func locationManager(_ manager : CLLocationManager, didFailWithError error : Error) {
        self.locationTextField.text = "Error while updating location" + error.localizedDescription
    }
}
