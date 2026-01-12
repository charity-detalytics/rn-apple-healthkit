Query for workout samples with extended information such as duration, energy, and source metadata.

```javascript
let options = {
  startDate: (new Date(2016, 4, 27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  limit: 10, // optional; default no limit
  includeManuallyAdded: false, // optional; default false (set true to include user-entered workouts)
};
```

```javascript
AppleHealthKit.getWorkoutSamples(options, (err, results) => {
  if (err) {
    return;
  }

  console.log(results);
});
```

Each workout result contains:

```
{
  duration: Number,         // seconds
  distance: Number,         // meters
  flightsClimbed: Number,
  swimmingStroke: Number,
  energy: Number,           // kilocalories
  start: String,            // ISO 8601 date string
  end: String,              // ISO 8601 date string
  type: String,             // human-readable workout type
  sourceId: String,
  sourceName: String,
}
```

When `includeManuallyAdded` is left as `false`, workouts that were entered manually in the Health app are excluded to match the previous default behavior. Set it to `true` to include manual entries. 
