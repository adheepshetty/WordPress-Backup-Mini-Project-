drop procedure test;
delimiter $$
create procedure test()
BEGIN
	DECLARE wordpress_db varchar(100);
	DECLARE wordpress_cursor_done INTEGER DEFAULT 0;
	DECLARE wp_users_done INTEGER DEFAULT 0;
    -- DECLARE table_not_found CONDITION for 1051;
    DECLARE value_mismatch CONDITION FOR 1048;
    
	
    
	DECLARE wordpress_cursor CURSOR FOR 
	select table_schema from information_schema.tables where table_name like '%_options%';

	
    
    DECLARE EXIT handler for value_mismatch (select "Trying to populate a non-null column with null value"); 
    -- DECLARE EXIT HANDLER FOR table_not_found (select "Please create table wp_users first");
	-- DECLARE EXIT HANDLER for sqlexception (select "Error!") ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET wordpress_cursor_done = 1;

	
	IF NOT EXISTS(select table_schema from information_schema.tables where table_name like '%_options%') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is no database with _options in it';
	END IF;
	
   
	OPEN wordpress_cursor;
	wordpress_cursor_loop:LOOP
		FETCH wordpress_cursor INTO wordpress_db;
		IF wordpress_cursor_done = 1 THEN
			LEAVE wordpress_cursor_loop;
		END IF;
		/*IF NOT EXISTS(select table_name from information_schema.tables where table_schema = wordpress_db and table_name like '%wp_users%') THEN
			SIGNAL SQLSTATE '99999' SET MESSAGE_TEXT = 'No table name wp_users';*/
		-- else
            set @wp_db = (Select wordpress_db);
			set @get_site_url = concat('SELECT  option_value as Website 
										into OUTFILE "file.csv" FIELDS TERMINATED BY ","
										FROM ', @wp_db,'.wp_options LEFT JOIN ' , @wp_db , '.wp_users ', 
										'ON option_value = user_email where option_name like "%home%"' );
            prepare stmt1 from @get_site_url ;
            execute stmt1;
            set @get_info = concat('SELECT  user_login as Name,user_pass as Password, option_value as Admin_email  
									FROM ', @wp_db,'.wp_options' ,'  
                                    JOIN ' , @wp_db , '.wp_users ',
                                    'ON option_value = user_email where option_name like "%admin%"');
            prepare stmt2 from @get_info;
            execute stmt2;
            select @get_site_url,@get_info;
            -- deallocate prepare stmt;
            
		-- END IF;    
	END LOOP;
	CLOSE wordpress_cursor;
END $$ 