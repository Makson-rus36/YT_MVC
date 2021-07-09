<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">
<@c.page>
    <h3>${userChannel.username}</h3>
    <div>${type}</div>
    <ui class="list-group">
        <#list users as user>
        <li class="list-group-item">
            <a href="/user-messages/${user.id}">${user.getUsername()}</a>
        </li>
        </#list>
    </ui>
</@c.page>
