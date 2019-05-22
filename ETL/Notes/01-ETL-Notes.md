# Folder Structure

```
YYYYMMDD ProjectName
        |
        |__1.Original Data  (never modify raw data)
        |
        |__2.Prepared Data
        |
        |__3.Uploaded Data
        |        |
        |        |__ YYYYMMDD (date of upload)
        |
        |__4.Analysis
        |
        |__5.Insights
        |
        |__6.Final
```

# Opening .csv Files in Excel

Sometimes, when you open a csv file in Excel, Excel automatically changes the format of the data. This can ruin your data set.

The bulletproof blueprint to opening csv files in excel:

1. Change the file extension from .csv to .txt
2. Open the file in Excel using the file menu
3. Since it is a .txt file, Excel will use the Text Import Wizard
4. Select 'Delimited' and click next
5. Set delimiters to 'Comma' only, Text qualifier to " and click next
6. Set column data format to 'Text' for every column in the Data Preview window. Click finish. Note: the column will turn black when selected.
