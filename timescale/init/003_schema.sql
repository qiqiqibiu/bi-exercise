CREATE TABLE kpi_1d
(
    time                                 timestamp with time zone NOT NULL,
    device_identifier                    bigint,
    org_identifier                       int,
    kpi_type_code                        character varying(50),
    kpi_count                            bigint,
    kpi_value_min                        numeric(19, 4),
    kpi_value_max                        numeric(19, 4),
    kpi_value_avg                        numeric(19, 4),
    kpi_value_last                       numeric(19, 4),
    kpi_value_text_last                  character varying(50),
    kpi_alert_condition_lower_limit_last numeric(19, 4),
    kpi_alert_condition_upper_limit_last numeric(19, 4),
    kpi_alert_condition_type_last        character varying(50),
    kpi_alert_condition_text_last        character varying(50),
    kpi_alert_count                      bigint
);

CREATE INDEX ix_kpi_1d_time ON kpi_1d USING btree (time);
CREATE INDEX ix_kpi_1d_device_identifier ON kpi_1d USING btree (device_identifier);
CREATE INDEX ix_kpi_1d_org_identifier ON kpi_1d USING btree (org_identifier);
CREATE INDEX ix_kpi_1d_kpi_type_code ON kpi_1d USING btree (kpi_type_code);

select create_hypertable('kpi_1d', 'time', migrate_data => true);
select set_chunk_time_interval('kpi_1d', INTERVAL '60 days');

CREATE TABLE kpi_type (
    code character varying(50) PRIMARY KEY,
    name character varying(255)
);