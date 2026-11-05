{* The mail of collected information for the forms of the ezwebin design.

   On an Exponential kernel with the HTML mail layout (notification.ini [MailSettings] HTMLLayout is the setting that
   came with it) the mail is the kernel's: an HTML part and a plain-text part from content/collectedinfomail_body.tpl
   and design:mail/layout.tpl, each answer shown by its "info" view, as on the result page.
   On an older kernel the mail stays the plain text it always was.
   Either way a form with a filled-in recipient field sends its mail there. *}
{def $ezwebin_html_mail = ezini_hasvariable( 'MailSettings', 'HTMLLayout', 'notification.ini' )}
{* The subject is a mail header, text: the object's name as it is (washed only in the old plain-text mail, as before) *}
{if $ezwebin_html_mail}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/ezwebin/collectedinfomail/form",,array($collection.object.name))}{/set-block}
{else}
{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/ezwebin/collectedinfomail/form",,array($collection.object.name|wash))}{/set-block}
{/if}

{if and(is_set($object.data_map.recipient), $object.data_map.recipient.has_content)}
{set-block scope=root variable=email_receiver}{$object.data_map.recipient.content}{/set-block}
{/if}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

{if $ezwebin_html_mail}
{include uri='design:content/collectedinfomail_body.tpl' collection=$collection ci_gui=true()
         ci_title="Collected information from %1"|i18n("design/ezwebin/collectedinfomail/form",,array($collection.object.name))
         ci_intro="The following information was collected"|i18n("design/ezwebin/collectedinfomail/form")}
{else}

{"The following information was collected"|i18n("design/ezwebin/collectedinfomail/form")}:

{foreach $collection.attributes as $attribute}
{$attribute.contentclass_attribute_name|wash}:
{attribute_result_gui view=info attribute=$attribute}

{/foreach}
{/if}
{undef $ezwebin_html_mail}
