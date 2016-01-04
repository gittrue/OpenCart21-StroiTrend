<h3><?php echo $text_common_cron_generate; ?></h3><form><p>For start work of this function you must add file admin/pcron_1.x.x.php(for Opencart ver 1.x.x) or  admin/pcron_2.x.x.php(for Opencart ver 2.x.x) to your crontab, that will be runs every 5 minutes. For do this you can use your cpanel or SSH connection, where you must run the next command</p><pre class="prettyprint">*/5 * * * * /**your_path_to_web_folder**/admin/pcron.php</pre><a data-afteraction="afterAction" data-action="save" data-scope=".closest('form').find('select')" class="pull-right btn ajax_action btn-success" type="button">Save</a><table class="table table-condensed no-border pd_bo_0">	<tbody>		<tr>			<th></th>			<th>Category</th>			<th>Scheduled</th>			<th>Last Activity</th>			<th>Duration (sec)</th>			<th>Last Count</th>			<th>Total Count</th>			<th>Status</th>		</tr> 	<?php foreach ($data['categoryEntity'] as $key => $val){		if($key == 'images' || $key == 'reviews' || $key == 'related_prod' || $key == 'urls')continue;		$cron = $val['cron'];		if(!isset($MD_CategoryEntites[$key]['type']))continue;	if($MD_CategoryEntites[$key]['type'] != 'generator')continue; ?>		<tr class="<?php if($data['categoryEntity'][$key]['cron']['status']) echo 'cron_on'; ?>">			<td>				<a data-jsbeforeaction="$btn.closest('tr').find('.cron-statistic').each(function(){$(this).html($(this).attr('data-default'))});" data-afteraction="afterAction" data-action="taskStatisticToNull" data-data="<?php echo $key; ?>" class="btn ajax_action" type="button">Clear Statistic Data</a>			</td>						<th>				<?php echo ${'text_category_name_'.$key}; ?>			</th>						<td class='cron-statistic' data-default="No activity">				<select name="data[categoryEntity][<?php echo $key; ?>][cron][scheduled]">					<?php $scheduled_list = array("5"=>"5 min","10"=>"10 min","15"=>"15 min","30"=>"30 min","60"=>"1 hour","360"=>"6 hours","720"=>"12 hours", "1440"=>"1 day", "4320"=>"3 days", "10080"=>"7 days");					foreach($scheduled_list as $scheduled_key=>$scheduled_type){?>						<option value="<?php echo $scheduled_key; ?>" <?php if($cron['scheduled'] == $scheduled_key) echo 'selected="selected"'; ?> ><?php echo $scheduled_type; ?></option>					<?php }	?>				</select>			</td>						<td class='cron-statistic' data-default="No activity">				<?php echo $cron['lastActivity'] != false ? gmdate("d/m/Y H:i:s", $cron['lastActivity']) : 'No activity'; ?>			</td>						<td class='cron-statistic' data-default="No activity">				<?php echo (int)$cron['lastDuration']; ?>			</td>						<td class='cron-statistic' data-default="0">				<?php echo $cron['lastCount']; ?>			</td>						<td class='cron-statistic' data-default="0">				<?php echo $cron['totalCount']; ?>			</td>					<td>				<div class="control-group">					<div class="controls">						<input type="hidden" name="data[categoryEntity][<?php echo $key; ?>][cron][status]" value="">						<input data-jsbeforeaction="if(!$btn.prop('checked')){$btn.closest('tr').removeClass('cron_on');}else{$btn.closest('tr').addClass('cron_on');}" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['categoryEntity'][$key]['cron']['status']) echo 'checked="checked"'; ?> name="data[categoryEntity][<?php echo $key; ?>][cron][status]" class="on_off">					</div>				</div>			</td>		</tr>	<?php } ?>		</tbody></table></form>	<p class="colorFC580B">Or, if you use Shared Hosting you can use this service www.easycron.com for running script every 5 minutes << in this case you must:</br>1. registered and set setting on www.easycron.com2. open in any text editor file admin/pcron_1.x.x or admin/pcron_2.x.x and comment lines OC.1.x >> 71-75 or OC.2.x >> 58-63:<pre>if (php_sapi_name() != 'cli') {    $log->write("ERROR - Paladin Cron: by browser access denied.");    http_response_code(400);    exit;}</pre>to<pre>//if (php_sapi_name() != 'cli') {//    $log->write("ERROR - Paladin Cron: by browser access denied.");//    http_response_code(400);//    exit;//}</pre></p><p class="colorFC580B">Cron-Generator can find and take on one operation no more 500 entities(products, categories,...) for generating. For example, if you set up cron for tags every 15 minutes and you have 1500 products - then 1500/500*15 = 45 << this is total time for generating tags for all products</p><div class="blog-post"><h2>Running PHP Scripts with Cron</h2>                  <div>                    <h3>Your PHP setup</h3><p>You will need to find out the answer to the following question, <strong>Is my PHP installed as CGI or as an Apache module?</strong><br>To find out do the following: Create a new file, name it <code>info.php</code> (just an example), and put in the following code:</p><pre>&lt;? phpinfo(); ?&gt;</pre><p>Upload to your web server and go to it with your browser. Now check for Server API (4th item from the top), if it says <code>CGI</code>, you have PHP compiled as CGI, if it reads <code>Apache</code>, you have it running as an Apache module. These days most PHP installations are done as a Apache web server modules.</p><h3>Compiled CGI</h3><p>If the answer to the question above is �CGI� then you need to add a line to your PHP script. It has to be the first line of your script and must contain your server�s PHP executable location:</p><pre class="prettyprint"><code><span class="com">#!/usr/local/bin/php -q</span></code></pre><p>That looks a lot like PERL now, doesn�t it? After that let�s add the necessary command to our crontab. Edit /etc/crontab and add the following line:</p><pre class="prettyprint"><code><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> php </span><span class="pun">/</span><span class="pln">path</span><span class="pun">/</span><span class="pln">to</span><span class="pun">/</span><span class="pln">your</span><span class="pun">/</span><span class="pln">admin/pcron_1.x.x</span><span class="pun">.</span><span class="pln">php</span></code></pre><p>Execute the following from the command line:</p><pre class="prettyprint"><code><span class="typ">Shell</span><span class="pun">&gt;</span><span class="pln"> crontab crontab</span></code></pre><p>Be sure your <code>admin/pcron_1.x.x.php</code> has the necessary permissions to be executable. If not, the shell command to do it is:</p><pre class="prettyprint"><span class="typ">Shell</span><span class="pun">&gt;</span><span class="pln"> chmod </span><span class="lit">755</span><span class="pln"> admin/pcron_1.x.x</span><span class="pun">.</span><span class="pln">php</span></pre><p>Now you are all set!</p><h3>Apache module</h3><p>If your PHP is installed using the Apache module, the approach is a little different. First, you need access to Lynx (<a href="http://lynx.isc.org/lynx2.8.5/index.html">Lynx Browser</a> for more information). Lynx is a small web browser, generally available on Unix and Linux.</p><p>Running your PHP script will not require you to add any additional lines. You simply have to edit your /etc/crontab file and add the following line:</p><pre class="prettyprint"><code><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> </span><span class="pun">*</span><span class="pln"> lynx </span><span class="pun">-</span><span class="kwd">dump</span><span class="pln"> http</span><span class="pun">:</span><span class="com">//www.somedomain.com/admin/pcron_1.x.x.php</span></code></pre><p>Please note that in general, you have to specify the entire URL (with �http://� and so on). But depending on your Lynx�s configuration, the URL might be relative; I suggest always using the absolute reference as in my example above � it always works.</p><p>Again execute the following from the command line:</p><pre class="prettyprint"><code><span class="typ">Shell</span><span class="pun">&gt;</span><span class="pln"> crontab crontab</span></code></pre><p>That all it takes to get a cron job setup using PHP. Hope you have learned something new and will use it to save overhead time on the server and on the developer.</p>                            </div>               </div><style>.cron_on{	background-color: rgb(209, 255, 208);	}	table.pd_bo_0 th, table.pd_bo_0 td{	padding-top: 10px;    padding-bottom: 0px;	}</style>