
/* log setting;

	1. sasv9_u8.cfg

		-LOGCONFIGLOC "D:\server\sas94\conf\log_congfig.xml"

	2. log_config.xml;

		<?xml version="1.0" encoding="UTF-8"?>
		<logging:configuration xmlns:logging="http://www.sas.com/xml/logging/1.0/">
		<!-- Rolling log file with default rollover of midnight -->
	   	<appender class="RollingFileAppender" name="RFA_TIME">
	      <param name="Append" value="true"/>
	      <param name="ImmediateFlush" value="true"/>
	      <param name="Threshold" value="TRACE"/>
	      <rollingPolicy class="TimeBasedRollingPolicy">
	         <param name="fileNamePattern" value="D:\server\sas94\log\log_%S{username}_%d.log"/>
	      </rollingPolicy>
	      <layout>
	         <param name="HeaderPattern" value="Host: '%S{hostname}',
												OS: '%S{os_family}', Release: '%S{os_release}',
												SAS Version: '%S{sup_ver_long2}', Command: '%S{startup_cmd}'"/>
	         <param name="ConversionPattern" value="%m"/>
	      </layout>
	   </appender>
	   <!-- Administration message logger -->
	   <logger name="root">
	      <level value="TRACE"/>
	   </logger>
	   <!-- Root logger -->
	   <root>
	      <appender-ref ref="RFA_TIME"/>
	   </root>
		</logging:configuration>

	3.replace (D:\server\sas94\log) with your own path;

	4.restart SAS;

*/


%macro test_fcmp_log;


	data _null_;
		call lerror('this is an error!');
		call lwarn('this is a warning!');
		call linfo('this is an msg!');
	run;


%mend;


%test_fcmp_log;
