<?php

/**
 * @file
 *
 * An example Install profile that uses Profiler. To create your own Install 
 * profile, copy the directory that this file resides in, and rename all files 
 * and directories, replacing profiler_example with the machine name of your 
 * install profile. Then do a find and replace in this file to replace all 
 * instances of profiler_example with the machine name of your profile. Edit the 
 * renamed profiler_example.info file to your taste, and presto-change-o,
 * you've got yourself an install profile!
 */

!function_exists('profiler_v2') ? require_once('libraries/profiler/profiler.inc') : FALSE;
profiler_v2('devdays');