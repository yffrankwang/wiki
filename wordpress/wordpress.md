### wp-config.php

	/**
	 * disable automatic update
	 */
	define( 'AUTOMATIC_UPDATER_DISABLED', true );

	/**
	 *
	 */
	define('FS_METHOD', 'direct');

### Fatal error: Uncaught phpmailerException: Invalid address: wordpress@_ 

	Reason: $_SERVER['SERVER_NAME'] = _
	nginx: 
		NG: server_name  _
		OK: server_name  www.xxx.com;

### Change Site URL in db

	SELECT * FROM wp_options WHERE option_name in ('siteurl', 'home');
	UPDATE wp_options SET option_value='http://yyy.com' WHERE option_name in ('siteurl', 'home');
	UPDATE wp_posts SET post_content = replace(post_content, 'http://xxx.com', 'http://yyy.com');
	UPDATE wp_postmeta set meta_value = replace(meta_value, 'http://xxx.com', 'http://yyy.com');

### Change Site URL in wp-config.php

	define('WP_HOME', 'http://yyy.com');
	define('WP_SITEURL', 'http://yyy.com');

### AWS S3 (WP Offload S3) Change Bucket

	SELECT * FROM wp_postmeta WHERE meta_key = 'amazonS3_info';
	UPDATE wp_posts SET post_content = replace(post_content, 'http://xxx.s3', 'http://yyyy.s3');
	UPDATE wp_postmeta set meta_value = replace(meta_value, 's:3:"xxx";', 's:4:"yyyy";')  where meta_key = 'amazonS3_info';

### Select Category

	SELECT tt.term_taxonomy_id, t.name, tt.taxonomy 
	FROM wp_term_taxonomy tt 
	LEFT JOIN wp_terms t ON tt.term_id = t.term_id
	WHERE tt.taxonomy = 'category';

### Select Posts with Permalink and Category
	SELECT
		p.ID,
		p.post_date as date,
		c.category,
		p.post_title as title,
		CONCAT(su.option_value,
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(o.option_value, '%year%', date_format(p.post_date, '%Y'))
			,'%monthnum%', date_format(p.post_date, '%m'))
			,'%day%', date_format(p.post_date, '%d'))
			,'%postname%', p.post_name)
			,'%category%', c.slug)
			) as permalink
	FROM wp_posts p
		INNER JOIN wp_options o on o.option_name = 'permalink_structure'
		INNER JOIN wp_options su on su.option_name = 'siteurl' 
		INNER JOIN (
			select tr.object_id ID, t.slug slug, t.name category
			from wp_term_relationships tr
				inner join wp_term_taxonomy tt on tt.term_taxonomy_id = tr.term_taxonomy_id and tt.taxonomy = 'category'
				inner join wp_terms t on t.term_id = tt.term_id
		) c on c.ID = p.ID
	WHERE p.post_type = 'post' AND p.post_status = 'publish'
	ORDER BY p.ID

### Select Posts with thumbnail
	SELECT
		p.ID,
		p.post_date as date,
		(SELECT meta_value FROM wp_post_meta WHERE post_id = p.ID and meta_key = '_thumbnail_id') as thumbnail
	FROM wp_posts p

### Transfer Posts to another DB
	insert into target.wp_posts
	SELECT ID + 10000,
		post_author,
		post_date,
		post_date_gmt,
		post_content,
		post_title,
		post_excerpt,
		post_status,
		comment_status,
		ping_status,
		post_password,
		post_name,
		to_ping,
		pinged,
		post_modified,
		post_modified_gmt,
		post_content_filtered,
		post_parent,
		guid,
		menu_order,
		post_type,
		post_mime_type,
		comment_count
	FROM source.wp_posts;

	insert into target.wp_postmeta 
	SELECT meta_id + 10000,
		post_id,
		meta_key,
		meta_value
	FROM source.wp_postmeta;
	update target.wp_postmeta set post_id = post_id + 10000 where meta_id > 10000;
	update target.wp_postmeta set meta_value = meta_value + 10000 where meta_id > 10000 and meta_key in ('_thumbnail_id');

	update target.wp_posts set guid = replace(guid, 'http://source.com/' , 'http://target.com/');
	update target.wp_posts set guid = concat('http://source.com/?p=', ID) where guid like 'http://target.com/?p=%');
	update target.wp_posts set post_content = concat(post_content, '<p>[This article is from SOURCE]</p>') where post_type = 'post' and post_status = 'publish';

