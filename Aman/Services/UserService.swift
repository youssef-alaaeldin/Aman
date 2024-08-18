import FirebaseAuth
import FirebaseFirestore

class UserService {
    private let db = Firestore.firestore()
    
    func fetchUserFavorites(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "UserID not found", code: 404, userInfo: nil)))
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let favoritePropertyIDs = document.data()?["favoritePropertyIDs"] as? [String] {
                    completion(.success(favoritePropertyIDs))
                } else {
                    completion(.success([]))
                }
            } else {
                completion(.failure(NSError(domain: "User document not found", code: 404, userInfo: nil)))
            }
        }
    }
    
    func fetchProperties(by ids: [String], completion: @escaping (Result<[Property], Error>) -> Void) {
        guard !ids.isEmpty else {
            completion(.success([]))  // Return an empty array if there are no favorite IDs
            return
        }
        
        db.collection("properties")
            .whereField(FieldPath.documentID(), in: ids)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let properties = snapshot?.documents.compactMap { document in
                        try? document.data(as: Property.self)
                    } ?? []
                    completion(.success(properties))
                }
            }
    }
    func addFavorite(propertyID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData([
            "favoritePropertyIDs": FieldValue.arrayUnion([propertyID])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Remove a property from the user's favorites
    func removeFavorite(propertyID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData([
            "favoritePropertyIDs": FieldValue.arrayRemove([propertyID])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    func fetchFavoriteProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        fetchUserFavorites { [weak self] result in
            switch result {
            case .success(let favoritePropertyIDs):
                self?.fetchProperties(by: favoritePropertyIDs, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
