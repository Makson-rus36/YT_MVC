<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>${username}</h5>
    ${message?ifExists}
    <form action="/user/profile" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-5">
                <input class="form-control" placeholder="Password" type="password" name="password"/>
            </div>
        </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"> Email: </label>
                <div class="col-sm-5">
                    <input class="form-control" placeholder="some@some.com" type="email" value="${email!''}" name="email"/>
                </div>
            </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary" type="submit">Save</button>
    </form>

</@c.page>
