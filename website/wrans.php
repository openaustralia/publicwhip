<?php include "cache-begin.inc"; ?>
<?php 
    # $Id: wrans.php,v 1.4 2003/12/08 18:36:02 frabcus Exp $

    # The Public Whip, Copyright (C) 2003 Francis Irving and Julian Todd
    # This is free software, and you are welcome to redistribute it under
    # certain conditions.  However, it comes with ABSOLUTELY NO WARRANTY.
    # For details see the file LICENSE.html in the top level of the source.

    include "db.inc";
    include "parliaments.inc";
	include "xquery.inc";
    $db = new DB(); 
    $title = html_scrub("Written Answers");
    include "header.inc";

    $prettysearch = html_scrub(trim($_GET["search"]));
    $shellsearch = escapeshellcmd(strtolower($prettysearch));
    $shellid = escapeshellcmd(html_scrub(trim($_GET["id"])));
?>

<p class="search">Search in Written Answers:</p>
<form class="search" action="wrans.php" name=pw>
<input maxLength=256 size=25 name=search value=""> <input type="submit" value="Search" name="button">
</form>

<?
	if ($prettysearch <> "")
	{
		$query = 'stag("wrans") ..  etag("wrans") containing word("' 
				. $shellsearch . '")';
		print $query;
		$result = sgrep_query("wrans", $query);
		print_transform("wrans-table.xslt", $result);	
	}
	
	if ($shellid <> "")
	{
		$query = 'stag("wrans") ..  etag("wrans") containing
			(attribute("id") containing attvalue("' . $shellid . '"))'; 
		print $query;
		$result = sgrep_query("wrans", $query);
		print_transform("wrans.xslt", $result);	
	}
?>

<?php include "footer.inc" ?>
<?php include "cache-end.inc"; ?>
