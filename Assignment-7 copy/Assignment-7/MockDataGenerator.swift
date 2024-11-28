import Foundation

class MockDataGenerator {
    static func generateMockData() {
        let directory = InsuranceDirectory.shared
        
        // Generate customers
        generateCustomers(directory)
        
        // Generate insurance policies
        generateInsurancePolicies(directory)
        
        // Generate claims
        generateClaims(directory)
        
        // Generate payments
        generatePayments(directory)
    }
    
    private static func generateCustomers(_ directory: InsuranceDirectory) {
        let customers = [
            Customer(id: 0, name: "John Doe", age: 35, email: "john@example.com"),
            Customer(id: 0, name: "Jane Smith", age: 28, email: "jane@example.com"),
            Customer(id: 0, name: "Bob Johnson", age: 42, email: "bob@example.com")
        ]
        
        for customer in customers {
            directory.addCustomer(customer: customer)
        }
    }
    
    private static func generateInsurancePolicies(_ directory: InsuranceDirectory) {
        let customers = directory.getCustomers()
        let currentDate = Date()
        let calendar = Calendar.current
        
        for customer in customers {
            let insurance = Insurance(
                id: 0,
                customer_id: customer.id,
                policy_type: InsuranceDirectory.insuranceTypes.randomElement()!,
                premium_amount: Double.random(in: 500...2000),
                start_date: currentDate,
                end_date: calendar.date(byAdding: .year, value: 1, to: currentDate)!
            )
            
            _ = directory.addInsurance(i: insurance)
        }
    }
    
    private static func generateClaims(_ directory: InsuranceDirectory) {
        let insurances = directory.getInsurances()
        
        for insurance in insurances {
            let claim = Claim(
                id: 0,
                policy_id: insurance.id,
                claim_amount: Double.random(in: 100...1000),
                date_of_claim: Date(),
                status: InsuranceDirectory.claimStatus.randomElement()!
            )
            
            _ = directory.addClaim(claim: claim)
        }
    }
    
    private static func generatePayments(_ directory: InsuranceDirectory) {
        let insurances = directory.getInsurances()
        
        for insurance in insurances {
            let payment = Payment(
                id: 0,
                policy_id: insurance.id,
                payment_amount: insurance.premium_amount,
                payment_date: Date(),
                payment_method: InsuranceDirectory.paymentMethod.randomElement()!,
                status: InsuranceDirectory.paymentStatus.randomElement()!
            )
            
            _ = directory.addPayment(payment: payment)
        }
    }
}
