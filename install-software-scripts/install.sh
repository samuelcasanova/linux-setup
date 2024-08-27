#!/bin/bash

# This script executes each script starting with 2 digits. If a parameter is given, the numbers prior to the parameter script will be ommited.

function check_exit_status () {
    local SCRIPT=$1
    if [ ! ${?} ]
    then
        echo -e "Error executing script ${SCRIPT}, aborting main script" >&2
        exit ${?}
    else
        echo "Script ${SCRIPT} completed successfully"
    fi
}

function execute_script () {
    local SCRIPT=$1
    local SCRIPT_NUMBER=${SCRIPT:2:2}
    if [ "${SCRIPT_NUMBER}" \< "${SKIP_UNTIL_NUMBER}" ]
    then
        echo "Skipping ${SCRIPT}"
    else
        . ${SCRIPT}
        check_exit_status ${SCRIPT}
    fi
}

# The first parameter is the name of the script to start with
SKIP_UNTIL=$1
if [ -n ${SKIP_UNTIL} ] && [ ! -f ${SKIP_UNTIL} ]
then
    echo 'ERROR The file specified in the parameter is not found' >&2
    exit 1
fi

if [ -z ${SKIP_UNTIL} ]
then
    echo 'Executing all the scripts'
    SKIP_UNTIL_NUMBER='00'
else
    echo "Executing from script '${SKIP_UNTIL}' onwards"
    SKIP_UNTIL_NUMBER=${SKIP_UNTIL:0:2}
fi

for SCRIPT in ./[0-9][0-9]*.sh
do
    execute_script ${SCRIPT}
done