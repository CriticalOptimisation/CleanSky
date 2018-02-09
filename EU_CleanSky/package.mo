within ;
package EU_CleanSky "Top level package for open source code developed under a Clean Sky JTI contract."
annotation (version="1.0", uses(                         DataFiles(version="1.0"), Modelica(
        version="3.2.1")),                 conversion(from(version="1.0 beta4", script="SafetyLibConvert1_0b5-1_0b6.mos"),
            from(version="1.0 beta5", script="SafetyLibConvert1_0b5-1_0b6.mos"),
            from(version="1.0 beta6", script="SafetyLibConvert1_0b5-1_0b7.mos"),
            from(version="1.0 beta7", script="SafetyLibConvert1_0b5-1_0b8.mos")));
end EU_CleanSky;
