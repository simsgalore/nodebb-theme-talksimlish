<ul component="category" class="list-unstyled topic-list overflow-auto position-relative" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}" data-set="{set}">

	{{{ each topics }}}
	<li component="category/topic" class="category-item position-relative {function.generateTopicClass}" <!-- IMPORT partials/data/category.tpl -->>
		<link itemprop="url" content="{config.relative_path}/topic/{./slug}" />
		<meta itemprop="name" content="{function.stripTags, ./title}" />
		<meta itemprop="itemListOrder" content="descending" />
		<meta itemprop="position" content="{./index}" />
		<a id="{./index}" data-index="{./index}" component="topic/anchor"></a>

		<div class="row flex-nowrap gap-2 align-items-start">
			<div class="content d-flex gap-2 flex-fill">
				<div class="flex-0">
					{{{ if ./thumbs.length }}}
					<div class="topic-thumb">
						<a href="{./thumbs.0.url}">
							<img class="topic-thumb rounded-1" src="{./thumbs.0.url}" class="not-responsive" />
						</a>
					</div>
					{{{ else }}}
					<div class="avatar">
						<a href="{{{ if ./user.userslug }}}{config.relative_path}/user/{./user.userslug}{{{ else }}}#{{{ end }}}" class="text-decoration-none">
							{buildAvatar(./user, "40px", true, "avatar-tooltip not-responsive")}
						</a>
					</div>
					{{{ end }}}
				</div>
				<div class="d-flex flex-column gap-1 flex-fill">
					<div class="d-flex align-items-start gap-1 mb-1 {{{ if showSelect }}}me-4{{{ end }}} me-md-0">
						{{{ if ./unread }}}<span class="text-primary mt-1" style="font-size:8px">&#9679;</span>{{{ end }}}
						<h2 component="topic/header" class="tracking-tight text-break title text-md fw-semibold m-0">
							{{{ if topics.noAnchor }}}
							<span>{./title}</span>
							{{{ else }}}
							<a class="text-reset" href="{config.relative_path}/topic/{./slug}{{{ if ./bookmark }}}/{./bookmark}{{{ end }}}">{./title}</a>
							{{{ end }}}
						</h2>
					</div>
					<div class="info d-flex align-items-center flex-wrap">
						<span component="topic/labels" class="d-flex mb-1">
							<span component="topic/scheduled" class="me-2 badge border border-gray-300 text-primary {{{ if !./scheduled }}}hidden{{{ end }}}">
								<i class="fa fa-clock-o"></i>
								[[topic:scheduled]]
							</span>
							<span component="topic/pinned" class="me-2 badge border border-gray-300 text-primary {{{ if (./scheduled || !./pinned) }}}hidden{{{ end }}}">
								<i class="fa fa-thumb-tack"></i>
								{{{ if !./pinExpiry }}}[[topic:pinned]]{{{ else }}}[[topic:pinned-with-expiry, {./pinExpiryISO}]]{{{ end }}}
							</span>
							<span component="topic/locked" class="me-2 badge border border-gray-300 text-primary {{{ if !./locked }}}hidden{{{ end }}}">
								<i class="fa fa-lock"></i>
								[[topic:locked]]
							</span>
							<span class="me-2 badge border border-gray-300 text-primary {{{ if !./oldCid }}}hidden{{{ end }}}">
								<i class="fa fa-arrow-circle-right"></i>
								[[topic:moved]]
							</span>
							{{{each ./icons}}}<span class="me-2">{@value}</span>{{{end}}}
						</span>


						{{{ if !template.category }}}
						<a class="lh-1 me-2 mb-1" href="{config.relative_path}/category/{./category.slug}">{function.buildCategoryLabel, ./category, "border"}</a>
						{{{ end }}}

						{{{ if ./tags.length }}}
						<span class="lh-1 tag-list hidden-xs d-flex flex-wrap gap-2 me-2 mb-1 ">
							{{{ each ./tags }}}
							<a href="{config.relative_path}/tags/{./valueEncoded}"><span class="badge border border-gray-300 text-xs fw-normal tag tag-class-{./class}" data-tag="{./value}">{./valueEscaped}</span></a>
							{{{ end }}}
						</span>
						{{{ end }}}

						<span class="hidden-xs text-xs timeago text-muted me-2 mb-1" title="{./timestampISO}"></span>

						<span class="visible-xs-inline timeago text-muted text-xs" title="{{{ if ./teaser.timestampISO }}}{./teaser.timestampISO}{{{ else }}}{./timestampISO}{{{ end }}}"></span>
					</div>
				</div>
			</div>

			<div class="meta d-none d-md-flex flex-0 gap-3">
				<div class="d-none d-lg-flex stats text-muted gap-2 px-0 align-items-start">
					{{{ if !reputation:disabled }}}
					<div class="stats-votes align-items-center card card-header px-1 py-2 border-0 rounded-1" style="min-width:3rem">
						<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./votes}" data-toFixed="0">{./votes}</span>
						<span class="text-lowercase text-xs">[[global:votes]]</span>
					</div>
					{{{ end }}}
					<div class="stats-postcount align-items-center card card-header px-1 py-2 border-0 rounded-1" style="min-width:3rem">
						<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./postcount}" data-toFixed="0">{./postcount}</span>
						<span class="text-lowercase text-xs">[[global:posts]]</span>
					</div>
					<div class="stats-viewcount align-items-center card card-header px-1 py-2 border-0 rounded-1" style="min-width:3rem">
						<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./viewcount}" data-toFixed="0">{./viewcount}</span>
						<span class="text-lowercase text-xs">[[global:views]]</span>
					</div>
				</div>

				<div class="teaser d-none d-md-flex overflow-hidden" component="topic/teaser">
					<div class="lastpost background-link-container border-start border-2 h-100" style="border-color: {./category.bgColor}!important;min-width:8rem">
						<a class="background-link" href="{config.relative_path}/topic/{./slug}/{./teaser.index}"></a>
						{{{ if ./unreplied }}}
						<p class="ps-3 text-xs lh-1">
							[[category:no_replies]]
						</p>
						{{{ else }}}
						{{{ if ./teaser.pid }}}
						<p class="ps-3 mb-0 lh-1">
							<a href="{config.relative_path}/user/{./teaser.user.userslug}" class="text-decoration-none">{buildAvatar(./teaser.user, "18px", true, "avatar-tooltip not-responsive")}</a>
							<a class="permalink text-muted timeago text-xs" href="{config.relative_path}/topic/{./slug}/{./teaser.index}" title="{./teaser.timestampISO}">
							</a>
						</p>
						<div class="post-content overflow-hidden text-xs line-clamp-2 ps-3">
							{./teaser.content}
						</div>
						{{{ end }}}
						{{{ end }}}
					</div>
				</div>
			</div>

			{{{ if showSelect }}}
			<div class="flex-0">
				<i component="topic/select" class="fa fa-square-o fs-5 text-muted pointer"></i>
			</div>
			{{{ end }}}
		</div>
		<hr class="text-muted opacity-25"/>
	</li>
	{{{end}}}
</ul>
