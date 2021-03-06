{**
 * Базовый шаблон топика
 *
 * @styles assets/css/topic.css
 * @scripts <framework>/js/livestreet/topic.js
 *}

{extends 'entry.base.tpl'}

{block 'entry_options'}
	{$oEntry = $oTopic}
	{$sEntryType = 'topic'}

	{$oBlog = $oTopic->getBlog()}
	{$oFavourite = $oTopic->getFavourite()}
	{$oTopicType = $oTopic->getTypeObject()}
{/block}


{* Иконки в заголовке топика *}
{block 'entry_title' prepend}
	{if $oTopic->getPublish() == 0}
		<i class="icon-file" title="{$aLang.topic_unpublish}"></i>
	{/if}
{/block}


{* Название блога *}
{block 'entry_header_info' prepend}
	<li class="topic-info-item topic-info-item-blog">
		<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape}</a>
	</li>
{/block}


{* Название блога *}
{block 'entry_body' append}
	{* Дополнительные поля *}
	{block name='topic_content_properties'}
		{if ! $bTopicList}
			{$aProperties = $oTopic->getPropertyList()}
			{$aInfoList = []}

			{foreach $aProperties as $oProperty}
				{$mValue = $oProperty->getValue()->getValueForDisplay()}

				{$aInfoList[] = [
					'label' => $oProperty->getTitle(),
					'content' => $oProperty->getValue()->getValueForDisplay()
				]}
			{/foreach}

			{include 'info_list.tpl' aInfoList=$aInfoList}
		{/if}
	{/block}

	{* Опросы *}
	{block name='topic_content_polls'}
		{if ! $bTopicList}
			{include file='polls/poll.list.tpl' aPollItems=$oTopic->getPolls()}
		{/if}
	{/block}
{/block}


{* Теги *}
{block 'entry_footer' prepend}
	{if ! $bTopicList and $oTopicType->getParam('allow_tags')}
		{include 'tag_list.tpl'
				 aTags = $oTopic->getTagsArray()
				 bTagsUseFavourite = true
				 aTagsFavourite = ($oFavourite) ? $oFavourite->getTagsArray() : []
				 sTagsFavouriteType = 'topic'
				 iTagsFavouriteId = $oTopic->getId()}
	{/if}
{/block}


{* Информация *}
{block 'entry_footer_info_items'}
	{* Голосование *}
	<li class="topic-info-item topic-info-item-vote">
		{include 'vote.tpl'
				 sVoteType       = 'topic'
				 oVoteObject     = $oTopic
				 sVoteClasses    = 'vote-small vote-white'
				 bVoteIsLocked   = $oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()
				 bVoteShowRating = $oVote || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()) || strtotime($oTopic->getDateAdd()) < $smarty.now - $oConfig->GetValue('acl.vote.topic.limit_time')}
	</li>

	{$smarty.block.parent}

	{if ! $bTopicList}
		{* Поделиться *}
		<li class="topic-info-item topic-info-item-share">
			<a href="#" class="icon-share js-popover-default" title="{$aLang.topic_share}" data-tooltip-target="#topic_share_{$oTopic->getId()}"></a>
		</li>
	{/if}
{/block}


{* Всплывающий блок появляющийся при нажатии на кнопку Поделиться *}
{block 'entry' append}
	<div class="tooltip" id="topic_share_{$oTopic->getId()}">
		<div class="tooltip-content js-tooltip-content">
			{hookb run="topic_share" topic=$oTopic bTopicList=$bTopicList}
				<div class="yashare-auto-init" data-yashareTitle="{$oTopic->getTitle()|escape}" data-yashareLink="{$oTopic->getUrl()}" data-yashareL10n="ru" data-yashareType="button" data-yashareQuickServices="yaru,vkontakte,facebook,twitter,odnoklassniki,moimir,lj,gplus"></div>
			{/hookb}
		</div>
	</div>
{/block}