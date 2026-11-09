<div class="border-box">

<div class="user-register">

<form enctype="multipart/form-data" action={"/user/register/"|ezurl} method="post" name="Register">

<div class="attribute-header">
 <h1 class="long">{"Register user"|i18n("design/ezwebin/user/register")}</h1>
</div>

{if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
 <div class="message-error">
 <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
 </div>
{/if}

{if $validation.processed}

 {if $validation.attributes|count|gt(0)}
 <div class="warning">
 <h2>{"Input did not validate"|i18n("design/ezwebin/user/register")}</h2>
 <ul>
 {foreach $validation.attributes as $attribute}
 <li>{$attribute.name}: {$attribute.description}</li>
 {/foreach}
 </ul>
 </div>
 {else}
 <div class="feedback">
 <h2>{"Input was stored successfully"|i18n("design/ezwebin/user/register")}</h2>
 </div>
 {/if}

{/if}

{if count($content_attributes)|gt(0)}
 {foreach $content_attributes as $attribute}
 {* the sign-up fields only: attributes of the class's "meta" category (Meta Data and other editorial settings) are
    left out, the user account gets no heading of its own (register=true() also drops the editor's User ID and
    account status), and an image is one plain upload field instead of the editor's image block *}
 {if $attribute.contentclass_attribute.category|eq( 'meta' )}{continue}{/if}
 <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
 {if eq( $attribute.data_type_string, 'ezimage' )}
 <div class="block register-image">
     <label for="register-image-{$attribute.id}">{$attribute.contentclass_attribute.name|wash}{if $attribute.is_required} *{else} ({'optional'|i18n( 'design/standard/user' )}){/if}</label><div class="labelbreak"></div>
     <input type="file" id="register-image-{$attribute.id}" name="ContentObjectAttribute_data_imagename_{$attribute.id}" accept="image/jpeg,image/png,image/webp,image/gif" />
     <label for="register-image-alt-{$attribute.id}">{'Describe the picture (read aloud by screen readers)'|i18n( 'design/standard/user' )}</label>
     <input type="text" class="box" id="register-image-alt-{$attribute.id}" name="ContentObjectAttribute_data_imagealttext_{$attribute.id}" maxlength="255" value="{$attribute.content.alternative_text|wash}" />
 </div>
 {elseif eq( $attribute.data_type_string, 'ezuser' )}
 <div class="block">
     {attribute_edit_gui attribute=$attribute register=true()}
 </div>
 {else}
 <div class="block">
     <label>{$attribute.contentclass_attribute.name|wash}</label><div class="labelbreak"></div>
     {attribute_edit_gui attribute=$attribute}
 </div>
 {/if}
 {/foreach}

 {include uri='design:mailpreferences/parts/signup.tpl' categories=first_set( $mail_categories, array() )}

 <div class="buttonblock">
 <input class="button" type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}">
 {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
 <input class="button" type="submit" id="PublishButton" name="PublishButton" value="{'Register'|i18n('design/ezwebin/user/register')}" data-ezwebin-disable-buttons="1">
 {else} 
 <input class="button" type="submit" id="PublishButton" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/ezwebin/user/register')}" data-ezwebin-disable-buttons="1">
 {/if}
 <input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Discard'|i18n('design/ezwebin/user/register')}" data-ezwebin-disable-buttons="1">
 </div>
{else}
 <div class="warning">
 <h2>{"Unable to register new user"|i18n("design/ezwebin/user/register")}</h2>
 </div>
 <input class="button" type="submit" id="CancelButton" name="CancelButton" value="{'Back'|i18n('design/ezwebin/user/register')}" data-ezwebin-disable-buttons="1">
{/if}
</form>

</div>

</div>

{ezscript( array( 'ezwebin_actions.js' ) )}
