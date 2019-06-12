let
    Source = Excel.Workbook(File.Contents("C:\Repos\ssis-training\extra-samples\Excel\pop-by-year.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Total population is based on the de facto definition of population, which counts all residents regardless of legal status or citizenship--except for refugees not permanently settled in the country of asylum, who are generally considered part of the population of their country of origin. The values shown are midyear estimates.", type text}, {"Column2", type any}, {"Column3", Int64.Type}, {"Column4", Int64.Type}, {"Column5", Int64.Type}, {"Column6", Int64.Type}, {"Column7", Int64.Type}, {"Column8", Int64.Type}, {"Column9", Int64.Type}, {"Column10", Int64.Type}, {"Column11", Int64.Type}, {"Column12", Int64.Type}, {"Column13", Int64.Type}, {"Column14", Int64.Type}, {"Column15", Int64.Type}, {"Column16", Int64.Type}, {"Column17", Int64.Type}}),
    #"Removed Top Rows" = Table.Skip(#"Changed Type",3),
    #"Promoted Headers1" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers1",{{"Country Name", type text}, {"1999", Int64.Type}, {"2000", Int64.Type}, {"2001", Int64.Type}, {"2002", Int64.Type}, {"2003", Int64.Type}, {"2004", Int64.Type}, {"2005", Int64.Type}, {"2006", Int64.Type}, {"2007", Int64.Type}, {"2008", Int64.Type}, {"2009", Int64.Type}, {"2010", Int64.Type}, {"2011", Int64.Type}, {"2012", Int64.Type}, {"2013", Int64.Type}, {"2014", Int64.Type}}),
    #"Unpivoted Columns" = Table.UnpivotOtherColumns(#"Changed Type1", {"Country Name"}, "Attribute", "Value"),
    #"Renamed Columns" = Table.RenameColumns(#"Unpivoted Columns",{{"Attribute", "Year"}, {"Value", "Population"}})
in
    #"Renamed Columns"