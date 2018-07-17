# JSON-Parsing-unkeyedcontainer

When using www.Quandl.com and retrieving data, its necessary to pass the data through a parser to obtain a model

Please note a user wishing to obtain data in this manner from Quandl must register with quandl and obtain an api-key to get data through it's service.  Registration is free. A typical file obtained from www.quandl.com in response to the correctly constructed call for data  - is supplied here as an example only.

Quandl encapsulates their returned data into a structure that any decoder being used must be instructed how to parse.  In this case an IOS function JSONDecoder is used.

Using the Codable protocol to define the parsing instructions eliminates the need for a third party library to parse this json into a model

This example is provided in the form of an Apple Playgroud

You may also wish to visit www.Cocoacasts.com for further help on Codable and its use as well as developer.apple.com https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
