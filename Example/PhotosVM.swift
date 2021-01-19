//
//  PhotosVM.swift
//  Example
//
//  Created by Ngavt on 1/18/21.
//

import Foundation
import Moya

class PhotosVM {
    let queueConcurrent = DispatchQueue(label: "dispatchqueueconcurrent", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 2)
    let group = DispatchGroup()
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getPhotos(vc: ViewController){
        
        let input: [String: Any] = [:]
        let target = MultiTarget(DownloadImageService.photos(params: input))
        NetworkManager.request(vc: vc, class: PhotoBO.self, target: target, success: { obj in
            vc.lstPhotos.append(contentsOf: obj)
        })
    }

    
    func downloadImage(fromUrl: String, closure: @escaping () -> Void) {
        if let url = URL(string: fromUrl) {
            getData(from: url) { data, response, error in
                guard let _ = data, error == nil else {
                    print("Download Fail")
                    closure()
                    return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                closure()
//                DispatchQueue.main.async() { [weak self] in
//                    self?.imageView.image = UIImage(data: data)
//                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        dataTask = defaultSession.dataTask(with: url, completionHandler: completion)
        dataTask?.resume()
    }
    
    func download10Image(lstPhotos: [PhotoBO]){
        dataTask?.cancel()
        for i in 0..<10 {
            if lstPhotos.count > i, let url = lstPhotos[i].url {
                self.semaphore.wait()
                group.enter()
                queueConcurrent.async {
                    self.downloadImage(fromUrl: url) {
                        self.group.leave()
                        self.semaphore.signal()
                    }
                }
            }
        }
        group.notify(queue: .main) {
            print("Download 10 image success!")
            self.dataTask?.cancel()
        }
    }
}
