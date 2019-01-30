-- call test();
drop procedure updatetest;
delimiter $$
create procedure updatetest()
BEGIN
	Declare wordpress_db varchar(100);
    DECLARE wordpress_cursor_done INTEGER DEFAULT 0;
	DECLARE wp_users_done INTEGER DEFAULT 0;
    
	DECLARE wordpress_cursor CURSOR FOR 
	select table_schema from information_schema.tables where table_name like '%wp_options%';
    
    OPEN wordpress_cursor;
    wordpress_cursor_loop:LOOP
		FETCH wordpress_cursor INTO wordpress_db;
        IF wordpress_cursor_done = 1 THEN
			LEAVE wordpress_cursor_loop;
		END IF;
        set @wp_db = (Select wordpress_db);
        /*set @get_site_url = concat('SELECT  option_value as Website FROM ', @wp_db,'.wp_options LEFT JOIN ' , @wp_db , '.wp_users', ' ON option_value = user_email where option_name = "home" ' );
        prepare stmt1 from @get_site_url;
        execute stmt1;
        set @get_info = concat('SELECT  user_login as Name,user_pass as Password, option_value as Admin_email  FROM ', @wp_db,'.wp_options' ,'  JOIN ' , @wp_db , '.wp_users',' ON option_value = user_email where option_name = "admin_email"');
        prepare stmt2 from @get_info;r
        execute stmt2;*/
        set @update_admin_pwd = concat('Update ',@wp_db,'.wp_users 
										set user_pass = "csulb1" 
										where user_email in (SELECT  option_value  
														FROM ', @wp_db,'.wp_options)'  );
        select @update_admin_pwd;
        prepare stmt3 from @update_admin_pwd;
        execute stmt3;
    END LOOP;
	CLOSE wordpress_cursor;
END $$
call updatetest();