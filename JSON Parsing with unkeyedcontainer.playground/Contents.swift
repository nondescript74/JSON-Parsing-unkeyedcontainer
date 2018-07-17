import Foundation

// Zahirudeen Premji
// July 15 2018
// 

// When using the web services supplied by www.quandl.com, the returning response from Quandl in json must be parsed into a model that is suitable for the application.
//  Not covered here is how the json got to the application - a file required to be decoded from json to a model required by the application is obtained by the app and supplied here as an example only.

// lets say the file is at an accessible url as below - url

guard let url = Bundle.main.url(forResource: "GCZ2018", withExtension: "json") else {
    fatalError()
}

// now lets create a Data object from the file to be used by a json decoder

guard let data = try? Data(contentsOf: url) else {
    fatalError()
}

// We create a function to be used later that when we supply the Data just created to the decoder

func serializeReceivedDataWithModel(data: Data) -> QuandlResponse   {
    
    let decoder = JSONDecoder()
    
    do  {
        let response = try decoder.decode(QuandlResponse.self, from: data)
        // print(response.dataset)
        return response
    }   catch   {
        print(error)
        fatalError()
    }
}

// Lets describe the model we wish to create from the Quandl data just created by provide the decoder with a struct - lets call it QuandlResponse and make it conform to the Codable protocol so that the json decode does all the work.

public struct QuandlResponse: Codable {
    
    public struct Dataset: Codable   {
        
        public let collapse: String?
        public let column_names: [String]
        public let database_code: String
        public let database_id: Int64
        public let dataset_code: String
        public let description: String
        public let end_date: String
        public let frequency: String
        public let id: Int64
        public let limit: Int64?
        public let name: String
        public let newest_available_date: String
        public let oldest_available_date: String
        public let order: String?
        public let premium: Bool
        public let refreshed_at: String
        public let start_date: String
        public let type: String
        public let data: [Datax]
        
        private let quandlkey = "dataset"
        
    }
    
    // inside this QuandlResponse struct above is another struct we use that encapsulates the data for each data point
    // in this case we have 8 data points plus a date for each day and each day is an array within an array - we must let the decoder know how the decode this.
    
    // We make the decoder use try to handle exceptions and we use optional chaining to ensure any missing data points get translated into nil values
    // Note its not clear from Quandl, which if any of the data points could be missing.  Sincle each data point must have a date, we make that the only item we believe we will get.
    
    // Let's define the Datax struct to show the decoder how to decode such a struct buried within the data.
    
    public struct Datax: Codable   {
        
        public let date: String
        public let open: Double?
        public let high: Double?
        public let low: Double?
        public let last: Double?
        public let change: Double?
        public let settle: Double?
        public let volume: Int64?
        public let previous_day_open_interest: Int64?
        
        // Let's provide an initializer so that the decoder has explicit instructions for each data point of 9 within the data.
        
        public init(from decoder: Decoder) throws  {
            var container = try decoder.unkeyedContainer()
            self.date = try container.decode(String.self)
            self.open = try container.decode(Double?.self)
            self.high = try container.decode(Double?.self)
            self.low = try container.decode(Double?.self)
            self.last = try container.decode(Double?.self)
            self.change = try container.decode(Double?.self)
            self.settle = try container.decode(Double?.self)
            self.volume = try container.decode(Int64?.self)
            self.previous_day_open_interest = try container.decode(Int64?.self)
        }
    }
    
    public let dataset: Dataset
}

// Let's use the function and obtain a model

let myQuandlResponseModel = serializeReceivedDataWithModel(data: data)

// let display the complete model

myQuandlResponseModel

// lets display parts of the model

myQuandlResponseModel.dataset.column_names
myQuandlResponseModel.dataset.description
myQuandlResponseModel.dataset.newest_available_date
myQuandlResponseModel.dataset.oldest_available_date


