Here are some articles and frameworks for testing SSIS packages.

First, a quite thorough article about unit and integration testing of SSIS packages. It's from 2013, and the "SSISTester" is pretty technical in the approach, but worth reading in terms of approach and ways of testing
https://msdn.microsoft.com/en-us/magazine/dn342874.aspx
The accompanying SSISTester framework can be found at https://archive.codeplex.com/?p=ssistester

Then, SSISUnit. Last update is from 2015, but it has full support for SSIS 2014, and there's documentation - which is good.
https://github.com/johnwelch/ssisUnit

There's also this fine blogpost about someone designing a test method for creating tests in SSIS. It's pretty high-level (and the author promised to share things on GitHub, but he hasn't done so for at least four years). 
https://kzhendev.wordpress.com/2014/05/21/building-an-ssis-testing-framework/

For integration testing, one framework that is still actively being developed is NBi (http://www.nbi.io/). You can coördinate your BI testing on a higher level, coördinating SQL Server tasks and SSIS tasks. It's built on nUnit.

Finally, the BEST (Biml Enabled SSIS Test) framework. Latest commit in 2014, but it's from the creators of BimlScript. Can be found at https://github.com/bimlscript/best.
