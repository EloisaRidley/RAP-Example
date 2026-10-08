
# R Project Template

GitHub template for R-based projects within the DHSC.

The template is intended to embed a standard approach to R programming
at DHSC and adheres to coding best practice as set out by the UK
Government Analytical Community - Quality assurance of code for analysis
and research (see
<https://best-practice-and-impact.github.io/qa-of-code-guidance/>).

## Usage

1.  In GitHub, create a new repository.

2.  Name your repository, give it a description, and fill in the required properties as usual (see [custom repo properties](https://crispy-adventure-qzrklvk.pages.github.io/repo-properties.html) for details) then click the "Continue: Configuration" button.

3.  Under the "Start with a template" option select `dhsc-govuk-internal/r-project-template` and click "Create repository" button (You do not need to change the "Include all branches" setting).

4.  Once the repository has been created, select the "Code" button and copy the HTTPS link to the repository.

5.  In RStudio, create a new git project by selecting *File* \> *New Project* \> *Version Control* \> *Git* then pasting in the link from above under "Repository URL" and fill in the rest of the options as normal.

6.  If your code needs any "secret" values that should not be version controlled create a `.Renviron` file in the projects base directory (the `.gitignore` is already configured to not commit this file).

7.  In the newly created project replace this `README.md` with the `README_TEMPLATE.md` - you can delete the old `README.md` as you can always refer to it in the [repository template](https://github.com/dhsc-govuk-internal/r-project-template).

## Contents

-   `main.R` - a standardised script to run your analysis. This script
    should be sourced by users and set up your environment, logging, and
    dependencies before running your analysis. Using a standard entry
    point to run the analysis will help others understand and use your
    code more quickly and also enforces more modular code. All other
    scripts should be saved in the `./R` folder with code structured
    into separate files containing logically grouped functions and
    sourced between scripts.

-   `./R`, `./input` and `./output` folders - store all code (except
    `main.R`) in the `./R` folder, input data and settings in the
    `./input` folder, and write any output from the analysis to the
    `./output` folder. Input and ouput folders contain `.gitignore`
    files which prevent their contents from being version controlled
    (with the exception of `./input/config.yaml`).

-   `./R/requirements.R` - use this script to install any packages that
    your code requires. This makes the code more portable as a new user
    of the analysis will have the required packages installed
    automatically on running the code.

-   `input/config.yaml` - a YAML file to store all input parameters and
    settings for the analysis. For sensitive parameters use a
    `.REnviron` file (this file is not version controlled by default in
    the template). The default `main.R` script will copy this across
    into a time stamped version after the analysis has run to aid
    reproducibility.

-   `README.md` - this document, please replace with
    `README_TEMPLATE.md` once you have finished creating your project.

-   `README_TEMPLATE.md` - a template readme file that can be filled out
    with details of your project.

-   `.gitignore` - a git ignore file that prevents certain files being
    version controlled. This will omit some standard files such as
    `.RData`, `.Rhistory`, etc.

-   `LICENSE.md` - default MIT license.

## Best practice

To help maintainability and QA, we recommended using the
[`tidyverse`](https://www.tidyverse.org/) framework along with the
associated [tidyverse style guide](https://style.tidyverse.org/). To
help style your code you should install the `lintr` and `styler` addin
packages which can then be accessed from the Addins drop down on the
tool bar.

### Documenting code

Please only use comments (`#`) to explain "why" you are doing something
rather than "what" your code is doing (unless you are using non-standard
or complex code).

Please add informative logger statements (`logger$info()`) about what
the code is doing but be careful of including these in loops as they
will produce a lot of superfluous output.

#### Function headers

Try to make sure that all functions are documented using
[roxygen2](https://roxygen2.r-lib.org/) comment headers. To add a
comment header place the cursor inside the function to be documented and
then either use the Ctrl + Alt + Shift + R shortcut or select *Code* \>
*Insert Roxygen skeleton* from the main menu (this can also be accessed
from the drop down opened by clicking the *Code tools* button in the
menu bar at the top of the script's tab).

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://dhsc-govuk-internal.github.io/user-guide.github.io/code-of-conduct.html).
By contributing to this project, you agree to abide by its terms.

## Licence

Unless stated otherwise, the codebase is released under the MIT License.
This covers both the codebase and any sample code in the documentation.
The documentation is © Crown copyright and available under the terms of
the [Open Government 3.0
licence](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
