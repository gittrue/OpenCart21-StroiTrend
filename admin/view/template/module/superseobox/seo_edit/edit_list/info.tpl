<?php 
	$type = 'info';
	$seo_edit_metadata = array(
		array('table' => 'information_description','col' => 'name', 'data_name' => 'name', 'type' => 'text', 'placement' => 'right'),
		array('table' => 'url_alias','col' => 'url_alias', 'data_name' => 'urls' , 'type' => 'text', 'placement' => 'right'),
		array('table' => 'information_description','col' => 'tag', 'data_name' => 'tags', 'placement' => 'right'),
		array('table' => 'information_description','col' => 'meta_keyword', 'data_name' => 'm_keywords'),
		array('table' => 'information_description','col' => 'meta_description', 'data_name' => 'm_descrip', 'placement' => 'left'),
		array('table' => 'information_description','col' => 'seo_title', 'data_name' => 'titles',  'placement' => 'left')
	);
	$th_name = $text_common_se_info_1;
?>
<?php require_once 'edit_list.tpl';?>
