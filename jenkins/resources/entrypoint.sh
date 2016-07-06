#!/bin/bash

#
# Copyright (c) 2001-2016 Primeton Technologies, Ltd.
# All rights reserved.
#
# author: ZhongWen Li (mailto:lizw@primeton.com)
#

if [ -z "${JENKINS_HOME}" ]; then
    JENKINS_HOME=~/jenkins_home
fi

if [ -z "${JAVA_OPTS}" ]; then
    JAVA_OPTS="-Xms256m -Xmx1024m"
    echo "[WARN ] JAVA_OPTS environment variable not set, use default JAVA_OPTS=${JAVA_OPTS}"
fi
JAVA_OPTS="${JAVA_OPTS} -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+CMSClassUnloadingEnabled -XX:SurvivorRatio=8 -XX:+DisableExplicitGC -XX:-OmitStackTraceInFastThrow -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="${JAVA_OPTS} -DJENKINS_HOME=${JENKINS_HOME}"

JENKINS_WAR=${PROGRAMS_HOME}/jenkins/jenkins.war
if [ ! -f ${JENKINS_WAR} ]; then
    echo "${JENKINS_WAR} not found."
    exit 0
fi

CMD="${JAVA_HOME}/bin/java -server ${JAVA_OPTS} -jar ${JENKINS_WAR}"
echo ${CMD}
${CMD}