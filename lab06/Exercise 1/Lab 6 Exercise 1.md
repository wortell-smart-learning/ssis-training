# Lab 6 Exercise 1

## Description
In lab 5, we developed an ETL package to load some extra sales data from CSV files.
However, apparently the data isn't always present. How do we handle that in a good way?

In exercise 1 (current exercise) we will implement error handling inside the control flow
In exercise 2 we will extend the error handling using "error flows" inside a data flow

## Steps

### Getting ready
1. Open "Lab 06 Exercise 1 start.sln" from the "start" folder, or continue where you left off after finishing lab 05.
2. Open package "Load Fact Reseller Sales.dtx"
3. Switch to the parameters tab
4. Replace the value of `C:\course\lab05\exports\` with `C:\course\lab06\exports\`

As you can see, the package fails (at least, it should). Do you have any clue on what goes wrong?

We will tackle this issue in three steps:
  * Catch errors inside the control flow. This way, unforseen errors can be handled graciously.
  * Identify erronous rows inside the data flow, so we can see what specifically goes wrong.
  * Fix the error at the source: change the package logic, or get a better CSV file.

### Handling errors in the Control Flow
First we will add some error handling to handle unforseen error graciously. In this specific case we'll put files with errors in a different folder.

5. Enlarge the FEL container somewhat by dragging the bottom corner down
6. Add a File System Task inside the FEL container
7. Configure the File System Task, so it will copy the file that's currently being processed to a subfolder called "error". When the folder containing the file is called `C:\course\lab06\exports`, the erronous file should be moved towards `C:\course\lab06\exports\error`.
8. Use a precedence constraint to ensure that this task will only be executed when the Data Flow Task fails

### Test
Execute the package again. Now, we can see which files caused errors inside the "error" subfolder (`C:\course\lab06\exports\error`).

### Bonus
When you execute the package once more, another error wil happen: the file cannot be copied to the "error" subfolder, because a file with the same name already exists. Two ways to handle this:
* Basic scenario: Remove everything from the "error" folder before writing (or overwrite existing files). This is not a scenario you should strive for, because you lose knowledge about earlier executions.
* Desired scenario: Inside the "error" folder, create another subfolder specifically for every execution of the package. A common way to ensure a unique name for a given execution is to use the execution start date and time. You'll need three things to construct this name:
  * The system variable containing the execution start time & date
  * An expression turning this variable into a usable string
  * A task creating the folder if it doesn't exist yet
  * (plus some logic to write erronuous files into this new folder)
  
Implement, depending on the amount of extra challenge you need, the basic or desired scenario.