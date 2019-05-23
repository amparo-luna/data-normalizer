# README:

This is an exercise that consists on using POROs to solve next problem:

In `app.rb`, `examples` car contains data that emulates what a search feature of a cars company runs into where they get car data from a wide variety of sources, and need to normalize the data.
Many times users will have typos or use shorthand in a given field.

In `examples`, left-hand hash represents data introduced to the system by a user meanwhile right-hand hash represents the expected output from the system.
The goal is to complete the normalize_data function to make the examples pass.

Next rules represent the business logic applied to left-hand hash to obtain the normalized data (ie the right-hand hash):
1. "trim" refers to different features or packages for the same model of vehicle
2. Valid years are from 1900 until 2 years in the future from today
3. A value that can't be normalized should be returned as is
4. Sometimes the trim of a vehicle will be provided in the "model" field, and will need to be extracted to the "trim" field
5. The word "blank" should be returned as nil

Points to evaluate:
1. Programming patterns implemented
2. Code structure

Average time to complete the excercise: ~4hrs
