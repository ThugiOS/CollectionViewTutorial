import Foundation

struct Product: Codable, Identifiable {
    var id = UUID()
    var name: String
    var price: Double
}
