//
//  AddPropertyView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 18/08/2024.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import SDWebImageSwiftUI

struct AddPropertyView: View {
    @State var name = ""
    @State var description = ""
    @State private var type: Property.PropertyType = .House
    @State var price = ""
    @State var location = ""
    @State var numberOfBedrooms = 2
    @State var numberOfBathrooms = 1
    @State var size = ""
    @State var images = [UIImage]()
    @State var imagePickerItem = [PhotosPickerItem]()
    @State var uploadedImages = [String]()
    @State private var isAddingProperty = false
    @EnvironmentObject private var viewModel : PropertyViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 15) {
                CustomTextField(textValue: $name, placeHolder: "Enter name",title: "Name")
                CustomTextField(textValue: $description, placeHolder: "Enter description",title: "Description")
                CustomTextField(textValue: $price, placeHolder: "Enter price" ,title: "Price")
                
                CustomTextField(textValue: $size, placeHolder: "Enter size" ,title: "Size")
                
                CustomTextField(textValue: $location, placeHolder: "Enter location" ,title: "Location")
                
                propertyType
                bathroomAndBedrooms
                
                PhotosPicker(selection: $imagePickerItem) {
                    Text("Select Photos")
                }
                
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<images.count, id: \.self) { image in
                            Image(uiImage: images[image])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 118)
                                .clipShape(.rect(cornerRadius: 10))
                            
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
                
                
                if isAddingProperty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    CustomButton(label: "Add Property") {
                        //ADD PROPERTY
                        addProperty()
                        
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onChange(of: imagePickerItem) { _, _ in
            Task {
                await imagesSelection()
            }
        }
    }
    
    private var propertyType: some View {
        VStack(alignment:.leading) {
            Text("Type")
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n900)
            
            Picker("Property Type", selection: $type) {
                ForEach(Property.PropertyType.allCases.filter { $0 != .All}, id: \.rawValue) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            
        }
    }
    
    private var bathroomAndBedrooms: some View {
        HStack {
            Stepper(value: $numberOfBathrooms, in: 1...10) {
                HStack(spacing: 5) {
                    Text("\(numberOfBathrooms)")
                    Image(systemName: "shower")
                }
            }
            
            Stepper(value: $numberOfBedrooms, in: 1...10) {
                HStack(spacing: 5) {
                    Text("\(numberOfBedrooms)")
                    Image(systemName: "bed.double")
                    //                            .font(.largeTitle)
                }
            }
        }
    }
    
    private func addProperty() {
        guard let propertyPrice = Double(price),
              let propertySize = Double(size) else {
            print("Invalid price or size input")
            return
        }
        isAddingProperty = true
        uploadImages { success in
            if success {
                viewModel.addProperty(
                    name: name,
                    description: description,
                    type: type,
                    price: propertyPrice,
                    location: location,
                    numberOfBedrooms: numberOfBedrooms,
                    numberOfBathrooms: numberOfBathrooms,
                    size: propertySize,
                    images: uploadedImages
                ) { result in
                    switch result {
                    case .success:
                        print("Property successfully added.")
                        self.isAddingProperty = false
                        presentationMode.wrappedValue.dismiss()
                    case .failure(let error):
                        print("Failed to add property: \(error.localizedDescription)")
                        // Show error message to the user if needed
                    }
                }
            } else {
                print("Failed to upload all images")
                // Handle the failure case appropriately
            }
        }
        
        print(name)
    }

    
    private func imagesSelection() async {
        for item in imagePickerItem {
            if let data = try? await item.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    images.append(image)
                }
            }
        }
        
        imagePickerItem.removeAll()
    }
    private func uploadImages(completion: @escaping (Bool) -> Void) {
        let storage = Storage.storage()
        var uploadCount = 0
        let totalImages = images.count
        
        guard totalImages > 0 else {
            completion(false)
            return
        }
        
        for image in images {
            let imageId = UUID().uuidString
            let ref = storage.reference().child("test2/\(imageId).jpg")
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                completion(false)
                return
            }
            
            ref.putData(imageData, metadata: nil) { metaData, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                ref.downloadURL { url, error in
                    if let error = error {
                        print("Failed to retrieve download URL: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    if let url = url {
                        DispatchQueue.main.async {
                            uploadedImages.append(url.absoluteString)
                            print("Successfully stored image with URL: \(url.absoluteString)")
                        }
                    }
                    
                    // Increment the counter and check if all uploads are complete
                    uploadCount += 1
                    if uploadCount == totalImages {
                        completion(true)  // All images uploaded successfully
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddPropertyView()
}
