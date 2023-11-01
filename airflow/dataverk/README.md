# Dataverk Airflow

Vårt default image for `KubernetesPodOperators` laget med [dataverk-airflow](https://pypi.org/project/dataverk-airflow/).

Dette imaget inneholder drivere for oracle, postgres, samt installasjoner av quarto og papermill CLI. Ønsker du ytterligere python pakker utover det som følger med base imaget vi tar utgangspunkt i (`python:3.11`) kan disse installeres ved runtime når man bruker `dataverk-airflow` som beskrevet i repo [readme](https://github.com/navikt/dataverk-airflow/tree/new_beginning#v%C3%A5re-operators).
