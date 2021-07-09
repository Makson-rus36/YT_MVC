<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form class="form-inline" method="get" action="/main">
                <input class="form-control" type="text" name="filter" placeholder="Search by tag" value="<#if filter??>${filter}</#if>">
                <button class="btn btn-primary ml-2" type="submit">Search</button>
            </form>
        </div>
    </div>
    <#include "parts/messageEdit.ftlh">
    <#include "parts/messageList.ftlh">
</@c.page>
