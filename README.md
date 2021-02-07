[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

# Data, Code and Workflows Guideline

To guide eBook authors having a better sense of the workflow layout, here we briefly introduce the specific purposes of the dir system. 


1. __cache__: Here, it stores intermediate datasets or results that are generated during the preprocessing steps.
2. __graphs__: The graphs/figures produced during the analysis.
3. __input__: Here, we store the raw input data. Data size > 100M is not allowed. We recommend using small sample data for the illustration purpose of the workflow. If you have files > 100M, please contact the chapter editor to find a solution. 
4. __lib__: The source code, functions, or algrithms used within the workflow.
5. __workflow__: Step by step pipeline for the protocol. It may contain some sub-directories. 
    - It is suggested to use __a numbering system__ and __keywords__ to indicate the order and the main purpose of the scripts, i.e., `1_fastq_quality_checking.py`, `2_cleaned_reads_alignment.py`.
    - To ensure reproducibility, please use the __relative path__ within the `workflow`.
6. __README__: In the readme file, please briefly describe the purpose of the repository, the installation, and the input data format. 
    - We recommend using a diagram to describe the workflow briefly.
    - Provide the installation details.
    - Show a small proportion of the input data, i.e., the `head` or `tail` of the input data.

## Overview of the workflow

## Installation

## Input Data

## Major steps

## Expected results


## License
It is a free and open source software, licensed under []() (choose a license from the suggested list:  [GPLv3](LICENSE)).
