
/* log setting;

	1. sasv9_u8.cfg

		add -LOGCONFIGLOC "D:\server\sas94\conf\log_congfig.xml"

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

%lstart;
%lfatal(this is a test fatal log send by OPEN_CODE);
%lerror(this is a test error log send by OPEN_CODE);
%lwarn(this is a test warn log send by OPEN_CODE);
%linfo(this is a test info log send by OPEN_CODE);
%ldebug(this is a test debug log send by OPEN_CODE);
%ltrace(this is a test trace log send by OPEN_CODE);
%lbreak(this is a test log break send by OPEN_CODE);


%macro a;
	%b;
%mend;

%macro b;
	%lfatal(this is a test fatal log send by B);
	%lerror(this is a test error log send by B);
	%lwarn(this is a test warn log send by B);
	%linfo(this is a test info log send by B);
	%ldebug(this is a test debug log send by B);
	%ltrace(this is a test trace log send by B);
	%lbreak(this is a test log break send by B);
	%c;
%mend;


%macro c;
	%lfatal(this is a test fatal log send by C);
	%lerror(this is a test error log send by C);
	%lwarn(this is a test warn log send by C);
	%linfo(this is a test info log send by C);
	%ldebug(this is a test debug log send by C);
	%ltrace(this is a test trace log send by C);
	%lbreak(this is a test log break send by C);
%mend;
%a;

*/

options nonotes;
data _null_;
	call lerror('data step msg eror!');
	call lwarn('data step msg warn!');
	call linfo('data step msg info!');
run;
