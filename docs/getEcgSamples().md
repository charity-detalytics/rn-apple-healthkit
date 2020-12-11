Query for ECG samples. the options object is used to setup a query to retrieve relevant samples.

```javascript
let options = {
  voltUnit: "mcV", // optional; default 'mcV'
  heartRateUnit: "bpm", // optional; default 'bpm'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
};
```

The callback function will be called with a `samples` array containing objects with *startDate*, *endDate*, *averageHeartRate*, *classification*, *samplingFrequency*, *ymptomsStatus*, *sourceId*, *sourceName* and *voltageMeasurements* fields where *voltageMeasurements* is an array of objects with *timeSinceSampleStart* (seconds) and *voltageQuantity* (voltUnit) fields

```
classification:
  0: "ClassificationNotSet",
  1: "ClassificationSinusRhythm",
  2: "ClassificationAtrialFibrillation",
  3: "ClassificationInconclusiveLowHeartRate",
  4: "ClassificationInconclusiveHighHeartRate",
  5: "ClassificationInconclusivePoorReading",
  6: "ClassificationInconclusiveOther",
symptomsStatus:
  0: "SymptomsStatusNotSet",
  1: "SymptomsStatusNone",
  2: "SymptomsStatusPresent",
```

```javascript
AppleHealthKit.getEcgSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
