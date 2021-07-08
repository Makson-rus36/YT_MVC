<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> User Name : </label>
            <div class="col-sm-5">
            <input class="form-control ${(usernameError??)?string('is-invalid','')}"
                   placeholder="User name" type="text"
                   name="username"
                   value="<#if user??>${user.username}</#if>"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-5">
                <input
                        class="form-control ${(passwordError??)?string('is-invalid','')}"
                        placeholder="Password" type="password" name="password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
         <#if isRegisterForm>
             <div class="form-group row">
                 <label class="col-sm-2 col-form-label"> Confirm password: </label>
                 <div class="col-sm-5">
                     <input
                             class="form-control ${(password2Error??)?string('is-invalid','')}"
                             placeholder="Confirm password" type="password"
                             name="password2"/>
                     <#if password2Error??>
                         <div class="invalid-feedback">
                             ${password2Error}
                         </div>
                     </#if>
                 </div>
             </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Email: </label>
            <div class="col-sm-5">
                <input class="form-control ${(emailError??)?string('is-invalid','')}"
                       placeholder="some@some.com"
                       type="email" name="email"
                       value="<#if user??>${user.email}</#if>"/>
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <#if !isRegisterForm>
        <a href="/registration">Регистрация</a>
            <#else >
                <a href="/login">Sign In</a>
        </#if>
        <button class="btn btn-primary" type="submit"><#if isRegisterForm>Create<#else>Sign In</#if></button>
    </form>
</#macro>

<#macro logout>
    <div>
        <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button class="btn btn-primary">Sign Out</button>
        </form>
    </div>
</#macro>
