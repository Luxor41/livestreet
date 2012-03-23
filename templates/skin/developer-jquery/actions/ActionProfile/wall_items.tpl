{foreach from=$aWall item=oWall}
	{assign var="oWallUser" value=$oWall->getUser()}
	{assign var="aReplyWall" value=$oWall->getLastReplyWall()}

	<div id="wall-item-{$oWall->getId()}" class="js-wall-item comment-wrapper">
		<div class="comment">
			<a href="{$oWallUser->getUserWebPath()}"><img src="{$oWallUser->getProfileAvatarPath(48)}" alt="avatar" class="comment-avatar" /></a>
			
			<ul class="comment-info clearfix">
				<li class="comment-author"><a href="{$oWallUser->getUserWebPath()}">{$oWallUser->getLogin()}</a></li>
				<li class="comment-date"><time datetime="{date_format date=$oWall->getDateAdd() format='c'}">{date_format date=$oWall->getDateAdd() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time></li>
			</ul>
			
			<div class="comment-content text">
				{$oWall->getText()}
			</div>
			
			{if !$aReplyWall}
				<ul class="comment-actions">
					<li><a href="#" class="link-dotted" onclick="return ls.wall.toggleReply({$oWall->getId()});">Ответить</a></li>
				</ul>
			{/if}
		</div>
		
		
		{if count($aReplyWall) < $oWall->getCountReply()}
			<a href="#" onclick="return ls.wall.loadReplyNext({$oWall->getId()});" id="wall-reply-button-next-{$oWall->getId()}" class="wall-more wall-more-reply">
				Показать все <span id="wall-reply-count-next-{$oWall->getId()}">{$oWall->getCountReply()}</span> {$oWall->getCountReply()|declension:$aLang.comment_declension:'russian'}
			</a>
		{/if}

		
		<div id="wall-reply-container-{$oWall->getId()}" class="comment-wrapper">
			{if $aReplyWall}
				{include file='actions/ActionProfile/wall_items_reply.tpl'}
			{/if}
		</div>
		
		
		<form class="wall-submit wall-submit-reply" {if !$aReplyWall}style="display: none"{/if}>
			<textarea rows="4" id="wall-reply-text-{$oWall->getId()}" class="input-text input-width-full js-wall-reply-text" placeholder="Ответить..." onclick="return ls.wall.expandReply({$oWall->getId()});"></textarea>
			<button type="button" onclick="ls.wall.addReply(jQuery('#wall-reply-text-{$oWall->getId()}').val(), {$oWall->getId()});" class="button button-primary">Отправить</button>
		</form>
	</div>
{/foreach}