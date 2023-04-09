#!/usr/bin/env bash

uptime -p \
| sed -E 's/ hours/H/' \
| sed -E 's/ hour/H/' \
| sed -E 's/ minutes/M/' \
| sed -E 's/ minute/M/' \
| cut -d' ' -f2- \
| sed -E 's/, /:/'
