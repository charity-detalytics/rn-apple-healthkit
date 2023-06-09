Query for AFib burden samples. the options object is used to setup a query to retrieve relevant samples.
Note: This API is only available for iOS 16+.

```javascript
let options = {
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthKit.getAFibBurdenSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
  { value: 20.5, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 19.1, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 21.9, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
]
```
