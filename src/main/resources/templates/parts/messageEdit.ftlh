<a class="btn btn-primary" data-toggle="collapse" href="#collapseMessageForm" role="button" aria-expanded="false" aria-controls="collapseExample">
    Message editor
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
                    <input  class="form-control" type="hidden" name="_csrf" value="${_csrf.token}">
                    <input  class="form-control" type="hidden" name="id" value="<#if message??>${message.id}</#if>">
                    <input  class="form-control" type="file" id="customFile" name="file">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-primary" type="submit">Save</button>
            </div>
        </form>
    </div>
</div>
