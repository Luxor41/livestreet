{**
 * Список пользователей
 *}

{if $aUsersList}
	{if $iSearchCount}
		<h3 class="h3">Найдено {$iSearchCount} человек</h3>
	{/if}

	{* Список пользователей *}
	<ul class="object-list user-list js-more-users-container">
		{include 'user_list.items.tpl' aUsersList=$aUsersList}
	</ul>

	{if $bUseMore}
		{if !$bHideMore}
			{include 'more.tpl'
				sLoadClasses    = 'js-more-search'
				sLoadTarget     = '.js-more-users-container'
				sLoadAttributes = 'data-search-type="users" data-proxy-page-next="2"  '}
		{/if}
	{else}
		{include 'pagination.tpl' aPaging=$aPaging}
	{/if}

{else}
	{include 'alert.tpl' mAlerts=(($sUserListEmpty) ? $sUserListEmpty : $aLang.blog.alerts.empty) sAlertStyle='empty'}
{/if}


