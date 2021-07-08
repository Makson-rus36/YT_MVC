<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form class="form-inline" method="get" action="/main">
                <input class="form-control" type="text" name="filter" placeholder="Search by tag" value="<#if filter??>${filter}</#if>">
                <button class="btn btn-primary ml-2" type="submit">Search</button>
            </form>
        </div>
    </div>
    <a class="btn btn-primary" data-toggle="collapse" href="#collapseMessageForm" role="button" aria-expanded="false" aria-controls="collapseExample">
        Add new message
    </a>
    <div class="collapsec <#if message??>show</#if>" id="collapseMessageForm">
        <div class="form-group mt-3">
            <form method="post" action="/main" enctype="multipart/form-data">
                <div class="form-group">
                    <input  class="form-control" type="hidden" name="_csrf" value="${_csrf.token}">
                </div>
                <div class="form-group">
                    <input  class="form-control ${(textMessageError??)?string('is-invalid','')}"
                            type="text" name="textMessage" placeholder="Введите сообщение"
                    value="<#if message??>${message.textMessage}</#if>">
                    <#if textMessageError??>
                    <div class="invalid-feedback">
                        ${textMessageError}
                    </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input  class="form-control"
                            value="<#if message??>${message.tag}</#if>"
                             type="text" name="tag" placeholder="Тег">
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input  class="form-control" type="file" id="customFile" name="file">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary" type="submit">Добавить</button>
                </div>
            </form>
        </div>
    </div>

<div class="card-columns">
    <#list messages as message>
        <div class="card my-3">
            <#if message.filename??>
                <img class="card-img-top" src="/img/${message.filename}">
            </#if>
            <div class="m-2">
                <b>${message.textMessage}</b>
                <i>${message.tag}</i>
            </div>
            <div class="card-footer text-muted">
                ${message.authorName}
            </div>
        </div>
    <#else>
        No message
    </#list>
</div>
</@c.page>
