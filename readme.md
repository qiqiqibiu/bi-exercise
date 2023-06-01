# Introduction
This repository contains the required input for completing a BI engineer exercise. The goal of the exercise is to create:
* At least one dashboard in Grafana
* At least one report in Jasper Reports
* Using a TimescaleDB database as datasource

The following software is required for this exercise:
* TimescaleDB 2.10.3 based on PostgreSQL 15
* Grafana OSS 9.5.2
* Jasper Reports Studio 6.20.0 (or newer)

# Scenario description
The supplied dataset is an export of device KPIs (Key Performance Indicators) for several device owning organizations. The KPIs are aggregated per day, over the course of multiple days.

The user would like:
* A report (intended for printing on A4 portrait), showing the performance of a device (1 page per device) for a given month. Ideally the report can be run:
  * for all devices of all organizations
  * for all devices of a single organization (organization should be an optional parameter)
  * for one device only (device should be an optional parameter)
* One or more dashboards, showing the performance of the devices over time.

A device is performing perfectly if all the KPIs for a device during a month are without alerts.

# Result
The result of this exercise is:
 - One or more Grafana dashboard definitions, stored as JSON files and committed to this GIT repository (see https://grafana.com/docs/grafana/latest/dashboards/manage-dashboards/#export-a-dashboard)
 - One or more Jasper Reports report definitions, stored as JRXML files and committed to this GIT repository

# Input Data

The sample dataset consists out of device KPIs (Key Performance Indicators), which have been aggregated per day. This dataset is the output of a process that samples all the different KPI values for devices every minute and aggregates these samples into day totals.

The sample data is included in this repository as gzipped CSV files:
* `data/kpi.csv.gz`
* `data/kpi_type.csv.gz`

When using the included docker setup, the data is loaded into the TimescaleDB schema defined in `timescale/init/003_schema.sql`.

## KPI

| Field                                | Description                                                                                                                   |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| time                                 | The time bucket start date/time                                                                                               |
| device_identifier                    | The identifier of the device                                                                                                  |
| org_identifier                       | The identifier of the organization owning the device                                                                          |
| kpi_type_code                        | The KPI type code referring to the KPI types from the `kpi_type` dataset                                                      |
| kpi_count                            | The amount of KPI samples in this specific time bucket (day)                                                                  |
| kpi_value_min                        | The minimum value of the KPI within the time bucket (day)                                                                     |
| kpi_value_max                        | The maximum value of the KPI within the time bucket (day)                                                                     |
| kpi_value_avg                        | The average value of the KPI within the time bucket (day)                                                                     |
| kpi_value_last                       | The last value of the KPI within the time bucket (day)                                                                        |
| kpi_value_text_last                  | The human readable formatted last value of the KPI within the time bucket (day)                                               |
| kpi_alert_condition_lower_limit_last | The last lower limit of the KPI's alert condition within the time bucket (day), can be `null` if no lower limit is specified. |
| kpi_alert_condition_upper_limit_last | The last upper limit of the KPI's alert condition within the time bucket (day), can be `null` if no upper limit is specified. |
| kpi_alert_condition_text_last        | The last human readable formatted KPI's alert condition within the time bucket (day).                                         |
| kpi_alert_condition_type_last        | The last condition type of the KPI's alert condition within the time bucket (day).                                            |
| kpi_alert_count                      | The amount of KPI samples in this specific time bucket (day) which meet the alert condition.                                  |

# Docker Setup
This repository contains a docker based setup that can be used for running the required TimescaleDB (loaded with the sample data) and a Grafana instance connected to this database. This setup requires a working docker environment and local ports `tcp/3000` and `tcp/5432` to be free. The setup has been verified to work on Ubuntu, MacOS and Windows (using WSL).

## Start
In order to start the docker compose based setup, run `start.sh`

Access the Grafana UI on: http://localhost:3000.

The TimescaleDB/PostgreSQL database is available at `localhost:5432` (can be directly accessed using `psql` using the `psql.sh` script)


## Stop
In order to stop the docker compose based setup, run `stop.sh`

Created Grafana dashboard will be lost when stopping the environment! The TimescaleDB data is retained.

## Clean
In order to stop and clean the docker compose based setup, run `clean.sh`

Created Grafana dashboard will be lost when stopping the environment! The TimescaleDB data is also removed when running clean.
