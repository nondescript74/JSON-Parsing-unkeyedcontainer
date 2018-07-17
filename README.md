# JSON-Parsing-unkeyedcontainer

When using www.Quandl.com and retrieving data, its necessary to pass the data through a parser to obtain a model
Please note the user must register with quandl and obtain an api-key to get data through it's service.  Registration is free.

A typical file required to be decoded from json to a model required by downstream application is supplied here as an example only.

Quandl encapsulates their returned data into a structure that any decoder being used (I show an example for IOS) must be instructed how to parse.

This eliminates the need for a third party library to parse json into a model

This example is provided in the form of an apple playgroud
