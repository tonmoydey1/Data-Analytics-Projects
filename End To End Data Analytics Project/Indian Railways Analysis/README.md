# Indian Railways Analysis

An end-to-end descriptive analytics project using Python, MySQL, and Power BI to examine train listings, station coverage, schedule entries, and operating day labels.

## Project overview

The project links a train master to recorded station entries using `Train_No`. It covers data inspection and preparation, relational analysis, and dashboard reporting. The dataset describes schedules; it does not measure actual journeys, delays, demand, occupancy, or revenue.

## Files

| File | Purpose |
| --- | --- |
| `train_info.csv` | 11,113 train records and 5 columns |
| `train_schedule.csv` | 186,074 station entries and 12 columns |
| `indian_railway.ipynb` | Python preparation and MySQL loading |
| `SqlAnalysis.sql` | KPI queries and business analysis |
| `Visualization.pbix` | Editable Power BI dashboard |
| `Dashboard.pdf` | Static dashboard export |
| `Railway_Analytics_Practice.docx` | Original business requirements |
| `Indian_Railways_Project_Report.docx` | Detailed project report and validation findings |
| `README.md` | Project overview and reproduction guide |

## Verified results

Recomputed from the CSV files on 9 October 2026, with the notebook's day-label correction applied.

| Metric | Value |
| --- | ---: |
| Distinct train numbers in master | 11,113 |
| Schedule entries | 186,074 |
| Distinct station codes | 8,147 |
| Trains with schedules | 11,113 |
| Trains missing schedules | 0 |
| Schedule trains missing details | 0 |
| Average entries per train | 16.74 |

- **Most station entries:** train 53041, HWH- JYG PAS, with 118.
- **Most distinct trains at a station:** CSMT / CST-MUMBAI, with 1,027.
- **Largest operating day group:** Friday, with 1,649; Monday has the smallest group, with 1,503.
- **Leading directional pairs:** CHENNAI BEACH to TAMBARAM and the reverse direction, with 137 trains each.

| Day | Distinct trains |
| --- | ---: |
| Monday | 1,503 |
| Tuesday | 1,628 |
| Wednesday | 1,612 |
| Thursday | 1,526 |
| Friday | 1,649 |
| Saturday | 1,593 |
| Sunday | 1,602 |

## Data model and counting rules

`train_info.Train_No` is unique and links one-to-many to `train_schedule.Train_No`. Prefer a single filter direction from the master to the schedule. Keep train numbers as text identifiers.

- Count trains by distinct `Train_No`, not `Train_Name`.
- Count stations by distinct `Station_Code`, not `Station_Name`.
- Count station entries as schedule rows, including source and destination entries.
- Count trains per station as distinct train numbers for each station code.
- Count trains with schedules as the intersection of train identifiers in both files.

The master fields are `Train_No`, `Train_Name`, `Source_Station_Name`, `Destination_Station_Name`, and `days`. The schedule contains `SN`, `Train_No`, `Station_Code`, `Station_Name`, `Route_Number`, `Arrival_time`, `Departure_Time`, `Distance`, `1A`, `2A`, `3A`, and `SL`. Confirm the units and meaning of Distance and class fields before using them as business measures.

## Workflow

1. Read and inspect the CSV files in Python.
2. Normalize column names and selected text, correct operating day labels, and parse times.
3. Load `train_info` and `train_schedule` into MySQL through SQLAlchemy and PyMySQL.
4. Run SQL joins and aggregations.
5. Refresh the Power BI report and compare its values with the validated metrics.

## Setup and use

Prerequisites: Python, Jupyter, MySQL, and Power BI Desktop for the full workflow. Dependencies are not version-pinned.

```bash
python -m pip install pandas numpy matplotlib seaborn sqlalchemy pymysql jupyter
jupyter notebook indian_railway.ipynb
```

Run the notebook from this project directory so its relative CSV paths resolve. Before running all cells:

1. Create a local MySQL database named `indian_railways_db`.
2. Replace the notebook's embedded connection credentials with your own configuration, preferably environment variables. Do not publish credentials.
3. Review the export cells: `if_exists="replace"` replaces the target tables.
4. For portable punctuation removal, change dictionary-style `str.replace` calls to `.str.replace(".", "", regex=False)`.
5. Read train numbers as text, retain `SN` if sequence analysis is needed, and parse times with `format="%H:%M:%S"`, checking conversion failures.

After loading the data, open `SqlAnalysis.sql` in a MySQL client and select `indian_railways_db`. Apply the query corrections below before relying on every result.

Open `Visualization.pbix` in Power BI Desktop, update the MySQL connection in Data source settings, verify the relationship and aggregations, then refresh. Check unfiltered totals and day-slicer behavior. Open `Dashboard.pdf` to view the existing dashboard without Power BI.

## Data quality and known issues

The CSVs have no missing cells or exact duplicate rows, and both train-number sets match completely. There are no negative Distance values. The source combination `(Train_No, Route_Number, SN)` is unique. A total of 1,153 day labels have an extra trailing `d`; the notebook maps these to seven standard day names.

The following issues remain in the original files and are documented rather than silently changed:

- SQL Question 1 counts distinct train names. Use `COUNT(DISTINCT train_no)`; the raw master has only 7,580 distinct names for 11,113 trains.
- SQL Question 2 counts station names. Use distinct station codes: 8,147 codes versus 8,099 raw names. Three station codes map to multiple raw names.
- The missing-details KPI and Question 5 do not correctly detect unmatched schedule identifiers. Use the anti-join below.
- SQL Question 6 groups only by train name. Group by both train number and name to keep separate trains apart.
- The dashboard's top-five station-entry chart groups names and aggregates train numbers from the master. Rebuild it using schedule-row counts by train number and name; its present ranking does not represent station entries per individual train.
- The dashboard uses station names in the station card. Align this with the station-code definition and show exact values alongside rounded cards.
- The notebook drops `SN`, infers train numbers as integers, and uses version-sensitive string replacement. Review these steps before reuse.

Correct missing-details check:

```sql
SELECT COUNT(DISTINCT s.train_no) AS missing_details
FROM train_schedule s
LEFT JOIN train_info i ON s.train_no = i.train_no
WHERE i.train_no IS NULL;
```

Correct top-five train query:

```sql
SELECT i.train_no, i.train_name, COUNT(*) AS station_entries
FROM train_info i
JOIN train_schedule s ON i.train_no = s.train_no
GROUP BY i.train_no, i.train_name
ORDER BY station_entries DESC, i.train_no
LIMIT 5;
```

## Limitations and validation status

Dataset provenance and observation dates are not documented in the project. These figures describe this snapshot, not the current railway network. A single day label per train does not establish a complete weekly timetable. Clock times without dates or day offsets cannot establish reliable journey durations, and midnight values require interpretation.

The documentation was checked against CSV calculations, saved notebook outputs, SQL text, the PDF export, and Power BI visual definitions. No live MySQL run or Power BI refresh was performed. Original analysis files remain unchanged. The full report provides methodology, findings, dashboard review, and recommended corrections.
