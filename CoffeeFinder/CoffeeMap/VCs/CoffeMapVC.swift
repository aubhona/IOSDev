//
//  CoffeeMapVC.swift
//
import UIKit
import MapKit
import CoreLocation

class CoffeeMapVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate
{
    var mapView: MKMapView! // Карта для показа местоположения и кофеен
    var tableView: UITableView! // Таблица для отображения списка кофеен
    let locationManager = CLLocationManager() // Менеджер геолокации
    var coffeeShops: [MKMapItem] = [] // Массив для найденных кофеен
    var currentRouteOverlays: [MKOverlay] = [] // Массив для маршрутов
    var selectedCoffeeShop: MKMapItem?
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemBackground
        setupMap()
        setupTableView()
        requestLocationAuthorization()
    }
    
    // MARK: - Настройка карты
    private func setupMap() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.pinTop(to: view)
        mapView.pinHorizontal(to: view)
        mapView.setHeight(UIScreen.main.bounds.height * 0.7)
        mapView.showsUserLocation = true
    }
    
    // MARK: - Настройка таблицы
    private func setupTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pinTop(to: mapView.bottomAnchor)
        tableView.pinHorizontal(to: view)
        tableView.pinBottom(to: view)
    }
    
    // MARK: - Запрос разрешения на использование геолокации
    private func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Настройка точности определения местоположения
        locationManager.requestWhenInUseAuthorization() // Запрос разрешения на постоянное использование геолокации
        locationManager.startUpdatingLocation() // Начало обновления информации о местоположении
    }
    
    // MARK: - Поиск кофеен
    private func searchCoffeeShops(in region: MKCoordinateRegion) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "coffee"
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Error")
                return
            }
            self.coffeeShops = response.mapItems
            self.tableView.reloadData()
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            for item in response.mapItems {
                let annotation = CoffeeShopAnnotation(title: item.name ?? "", coordinate: item.placemark.coordinate, info: "")
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    // MARK: - Маршрут до выбранной кофейни
    private func routeToCoffeeShop(destination: MKMapItem) {
        mapView.removeOverlays(currentRouteOverlays)
        currentRouteOverlays.removeAll()
        if lastKnownLocation == nil && locationManager.location?.coordinate == nil {
            return
        }
        var sourceCoordinate = locationManager.location?.coordinate
        if (sourceCoordinate == nil) {
            sourceCoordinate = lastKnownLocation!
        }
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate!)
        let destinationPlacemark = MKPlacemark(coordinate: destination.placemark.coordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Error")
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            self.currentRouteOverlays.append(route.polyline)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //            locationManager.stopUpdatingLocation()
            if  (lastKnownLocation == nil) {
                let userLocation = location.coordinate
                let regionRadius: CLLocationDistance = 1000
                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                mapView.setRegion(region, animated: true)
                searchCoffeeShops(in: region)
                self.lastKnownLocation = userLocation
                return
            }
            let userLocation = location.coordinate
            if userLocation.distance(from: lastKnownLocation!) > 11.8 {
                let regionRadius: CLLocationDistance = 1000
                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                
                searchCoffeeShops(in: region)
                if let destination = selectedCoffeeShop {
                    routeToCoffeeShop(destination: destination)
                }
            }
            self.lastKnownLocation = userLocation
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let coffeeShop = coffeeShops[indexPath.row]
        cell.textLabel?.text = coffeeShop.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCoffeeShop = coffeeShops[indexPath.row]
        routeToCoffeeShop(destination: selectedCoffeeShop!)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else if let cluster = annotation as? MKClusterAnnotation {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
                view?.markerTintColor = .red
                view?.glyphText = "\(cluster.memberAnnotations.count)"
            } else {
                view?.annotation = annotation
            }
            return view
        } else {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "CoffeeShopAnnotation") as? MKMarkerAnnotationView
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CoffeeShopAnnotation")
                view?.glyphTintColor = .white
                view?.markerTintColor = .brown
            } else {
                view?.annotation = annotation
            }
            view?.clusteringIdentifier = "coffeeShop"
            return view
        }
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize, backgroundColor: UIColor) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.addEllipse(in: rect)
        context.clip()
        
        context.setFillColor(backgroundColor.cgColor)
        context.fill(rect)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension CLLocationCoordinate2D {
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return from.distance(from: to)
    }
}
