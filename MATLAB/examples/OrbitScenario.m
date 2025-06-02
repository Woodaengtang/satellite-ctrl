close all; clear all; clc;
startTime = datetime(2020,6,02,8,23,0);
stopTime = startTime + hours(5);
sampleTime = 60;
sc = satelliteScenario(startTime,stopTime,sampleTime);

sat = satellite(sc, "threeSatelliteConstellation.tle");

show(sat);