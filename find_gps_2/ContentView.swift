//
//  ContentView.swift
//  find_gps_2
//
//  Created by Bob Bulliard on 3/31/22.
//
import Foundation
import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
       MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class LocationManager: NSObject   {
    
    private let locationManager = CLLocationManager()
    var location: CLLocation? = nil
    
    override init() {
        super.init()
      //  self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLDistanceFilterNone
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView  {
       
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }
    func updateUIView(_ uiView: MKMapView, context:  UIViewRepresentableContext<MapView>) {
        
    }
}
final class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapView
    init(_ control: MapView) {
        self.control = control
    }
}

